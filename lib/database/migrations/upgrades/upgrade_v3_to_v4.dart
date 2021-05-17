import 'package:inspiral/database/schema.dart';
import 'package:sqflite/sqflite.dart';

Future<void> upgradeV3ToV4(Database db) async {
  var batch = db.batch();

  batch.execute('''
    ALTER TABLE ${Schema.state}
    ADD ${Schema.state.maxSnapshotVersion} INTEGER NOT NULL DEFAULT 0
  ''');

  batch.rawUpdate('''
    UPDATE ${Schema.state}
    SET ${Schema.state.maxSnapshotVersion} = ${Schema.state.currentSnapshotVersion}
  ''');

  await batch.commit(noResult: true);
}
