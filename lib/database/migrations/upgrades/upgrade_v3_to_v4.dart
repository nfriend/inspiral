import 'package:inspiral/database/schema.dart';
import 'package:sqflite/sqflite.dart';

void upgradeV3ToV4(Batch batch) {
  batch.execute('''
    ALTER TABLE ${Schema.state}
    ADD ${Schema.state.maxSnapshotVersion} INTEGER NOT NULL DEFAULT 0
  ''');

  batch.rawUpdate('''
    UPDATE ${Schema.state}
    SET ${Schema.state.maxSnapshotVersion} = ${Schema.state.currentSnapshotVersion}
  ''');
}
