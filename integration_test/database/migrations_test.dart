import 'package:flutter_test/flutter_test.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/auto_draw_speed.dart';
import 'package:inspiral/util/delete_database.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sqflite/sqflite.dart' hide deleteDatabase;

import 'helpers/seed_v1_data.dart';
import 'helpers/seed_v3_data.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final testDatabaseName = 'inspiral-integration-tests.db';

  group('database migration tests', () {
    Database db;

    setUpAll(() async {
      await deleteDatabase(databaseName: testDatabaseName);
    });

    tearDown(() async {
      await db.close();
    });

    testWidgets('upgrade from version 0 to version 1',
        (WidgetTester tester) async {
      db = await getDatabase(version: 1, databaseName: testDatabaseName);

      await seedV1Data(db);

      var tableToRowCountMap = {
        Schema.colors: 23,
        Schema.state: 1,
        Schema.inkLines: 2,
        Schema.lineSegments: 3,
        Schema.points: 4,
        Schema.tileData: 2,
        Schema.tileSnapshots: 3,
      };

      // Just some smoke tests
      for (var tableAndCount in tableToRowCountMap.entries) {
        var tableName = tableAndCount.key.toString();
        var rows = await db.query(tableName);
        var expected = tableAndCount.value;
        var actual = rows.length;

        expect(actual, expected,
            reason:
                'Expected table $tableName to have $expected rows, but it has $actual rows');
      }
    });

    testWidgets('upgrade from version 1 to version 2',
        (WidgetTester tester) async {
      db = await getDatabase(version: 2, databaseName: testDatabaseName);

      final rows = await db.query(Schema.state.toString());

      expect(rows.length, 1);
      expect(rows[0][Schema.state.fixedGearIsLocked], 0);
    });

    testWidgets('upgrade from version 2 to version 3',
        (WidgetTester tester) async {
      db = await getDatabase(version: 3, databaseName: testDatabaseName);

      await seedV3Data(db);

      final stateRows = await db.query(Schema.state.toString());

      expect(stateRows.length, 1);
      expect(stateRows[0][Schema.state.snapPointsAreActive], 1);

      final snapPointRows = await db.query(Schema.snapPoints.toString());

      expect(snapPointRows.length, 3);
    });

    testWidgets('upgrade from version 3 to version 4',
        (WidgetTester tester) async {
      db = await getDatabase(version: 4, databaseName: testDatabaseName);

      final stateRows = await db.query(Schema.state.toString());

      expect(stateRows.length, 1);
      expect(stateRows[0][Schema.state.currentSnapshotVersion], 2);
      expect(stateRows[0][Schema.state.maxSnapshotVersion], 2);
    });

    testWidgets('upgrade from version 4 to version 5',
        (WidgetTester tester) async {
      db = await getDatabase(version: 5, databaseName: testDatabaseName);

      final stateRows = await db.query(Schema.state.toString());

      expect(stateRows.length, 1);
      expect(stateRows[0][Schema.state.autoDrawSpeed], AutoDrawSpeed.slow);
    });

    testWidgets('upgrade from version 5 to version 6',
        (WidgetTester tester) async {
      db = await getDatabase(version: 5, databaseName: testDatabaseName);

      final colorsQuery = '''
        SELECT
          c1.${Schema.colors.value} AS ${Schema.state.selectedPenColor},
          c2.${Schema.colors.value} AS ${Schema.state.selectedCanvasColor},
          c3.${Schema.colors.value} AS ${Schema.state.lastSelectedPenColor},
          c4.${Schema.colors.value} AS ${Schema.state.lastSelectedCanvasColor}
        FROM
          ${Schema.state} s
        LEFT JOIN ${Schema.colors} c1 ON c1.${Schema.colors.id} = s.${Schema.state.selectedPenColor}
        LEFT JOIN ${Schema.colors} c2 ON c2.${Schema.colors.id} = s.${Schema.state.selectedCanvasColor}
        LEFT JOIN ${Schema.colors} c3 ON c3.${Schema.colors.id} = s.${Schema.state.lastSelectedPenColor}
        LEFT JOIN ${Schema.colors} c4 ON c4.${Schema.colors.id} = s.${Schema.state.lastSelectedCanvasColor}
      ''';

      final colorRowsBefore = await db.query(Schema.colors.toString(),
          orderBy: '"${Schema.colors.order}"');
      final stateRowsBefore = await db.query(Schema.state.toString());
      final colorValuesBefore = (await db.rawQuery(colorsQuery))[0];

      expect(colorRowsBefore.length, 23);
      expect(stateRowsBefore.length, 1);

      final stateRowBefore = stateRowsBefore[0];

      await db.close();

      db = await getDatabase(version: 6, databaseName: testDatabaseName);

      // All undo snapshots. A `null` version is used to indicate the "current"
      // (i.e. not yet recorded) snapshot
      final allVersions = [0, 1, null];

      // There now should be 4 copies of all the color rows. One for the current
      // version (`null`), and 2 for the historical snapshots (0 and 1)
      final allColorRowsAfter = await db.query(Schema.colors.toString());
      expect(allColorRowsAfter.length, colorRowsBefore.length * 3);

      for (var version in allVersions) {
        final whereClause = version == null ? 'IS NULL' : '= $version';
        final colorRowsForVersion = await db.query(Schema.colors.toString(),
            where: '${Schema.colors.version} $whereClause',
            orderBy: '"${Schema.colors.order}"');

        expect(colorRowsForVersion.length, colorRowsBefore.length);

        for (var i = 0; i < colorRowsBefore.length; i++) {
          var colorRowBefore = colorRowsBefore[i];
          var colorRowAfter = colorRowsForVersion[i];

          if (version == null) {
            expect(colorRowAfter[Schema.colors.id],
                colorRowBefore[Schema.colors.id]);
          } else {
            expect(colorRowAfter[Schema.colors.id],
                isNot(equals(colorRowBefore[Schema.colors.id])));
          }

          expect(colorRowAfter[Schema.colors.version], version);
          expect(colorRowAfter[Schema.colors.value],
              colorRowBefore[Schema.colors.value]);
          expect(colorRowAfter[Schema.colors.type],
              colorRowBefore[Schema.colors.type]);
          expect(colorRowAfter[Schema.colors.order],
              colorRowBefore[Schema.colors.order]);
        }
      }

      // Similar to above, there should now be 2 additional rows in this table,
      // one for each version: 0, 1, and `null` (current)
      final allStateRowsAfter = await db.query(Schema.state.toString());
      expect(allStateRowsAfter.length, stateRowsBefore.length * 3);

      for (var version in allVersions) {
        var stateRowsAfterForVersion = allStateRowsAfter
            .where((row) => row[Schema.state.version] == version)
            .toList();

        expect(stateRowsAfterForVersion.length, 1,
            reason: 'No state row found for version $version');

        var stateRowAfter = stateRowsAfterForVersion[0];

        if (version == null) {
          expect(stateRowAfter[Schema.state.currentSnapshotVersion], 2);
        } else {
          expect(stateRowAfter[Schema.state.currentSnapshotVersion], version);
        }

        for (var entry in stateRowAfter.entries) {
          if ([
            Schema.state.currentSnapshotVersion,
            Schema.state.selectedPenColor,
            Schema.state.selectedCanvasColor,
            Schema.state.lastSelectedPenColor,
            Schema.state.lastSelectedCanvasColor,
            Schema.state.currentSnapshotVersion,
            Schema.state.version,
          ].contains(entry.key)) {
            continue;
          }

          expect(entry.value, stateRowBefore[entry.key]);
        }
      }

      // Test that all the color references are correct for each version
      for (var version in allVersions) {
        final whereClause = version == null ? 'IS NULL' : '= $version';
        final colorValuesAfter = (await db.rawQuery('''
          $colorsQuery
          WHERE s.${Schema.state.version} $whereClause
        '''))[0];

        expect(colorValuesBefore, equals(colorValuesAfter));
      }
    });
  });
}
