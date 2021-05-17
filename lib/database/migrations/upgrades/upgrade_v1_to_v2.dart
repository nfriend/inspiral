import 'package:inspiral/database/schema.dart';
import 'package:sqflite/sqflite.dart';

Future<void> upgradeV1ToV2(Database db) async {
  var batch = db.batch();

  batch.execute('''
    ALTER TABLE ${Schema.state}
    ADD ${Schema.state.fixedGearIsLocked} INTEGER CHECK(${Schema.state.fixedGearIsLocked} IN (0, 1)) NOT NULL DEFAULT 0
  ''');

  await batch.commit(noResult: true);
}
