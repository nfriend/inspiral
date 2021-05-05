import 'package:flutter_test/flutter_test.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/util/delete_database.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sqflite/sqflite.dart' hide deleteDatabase;

import 'helpers/seed_v1_data.dart';

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
  });
}
