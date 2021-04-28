import 'package:sqflite/sqlite_api.dart';
import 'package:inspiral/database/schema.dart';

Future<void> onDatabaseUpgrade(
    Database db, int oldVersion, int newVersion) async {
  var batch = db.batch();
  if (oldVersion == 1) {
    _updateTableStateV1toV2(batch);
  }
  await batch.commit();
}

void _updateTableStateV1toV2(Batch batch) {
  batch.execute('''
    ALTER TABLE ${Schema.state}
    ADD ${Schema.state.fixedGearIsLocked} INTEGER CHECK(${Schema.state.fixedGearIsLocked} IN (0, 1)) NOT NULL DEFAULT 0
  ''');
}
