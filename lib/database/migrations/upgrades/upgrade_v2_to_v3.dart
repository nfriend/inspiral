import 'package:inspiral/database/schema.dart';
import 'package:sqflite/sqflite.dart';

Future<void> upgradeV2ToV3(Database db) async {
  var batch = db.batch();

  _createTableSnapPoints(batch);
  _addSnapPointsAreActiveColumn(batch);

  await batch.commit(noResult: true);
}

void _createTableSnapPoints(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.snapPoints}');
  batch.execute('''
    CREATE TABLE ${Schema.snapPoints} (
      ${Schema.snapPoints.id} TEXT NOT NULL PRIMARY KEY,
      ${Schema.snapPoints.x} REAL NOT NULL,
      ${Schema.snapPoints.y} REAL NOT NULL,
      ${Schema.snapPoints.isActive} INTEGER CHECK(${Schema.snapPoints.isActive} IN (0, 1)) NOT NULL,
      ${Schema.snapPoints.version} INTEGER NULL
    )
  ''');
}

void _addSnapPointsAreActiveColumn(Batch batch) {
  batch.execute('''
    ALTER TABLE ${Schema.state}
    ADD ${Schema.state.snapPointsAreActive} INTEGER CHECK(${Schema.state.fixedGearIsLocked} IN (0, 1)) NOT NULL DEFAULT 1
  ''');
}
