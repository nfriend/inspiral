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
  });
}
