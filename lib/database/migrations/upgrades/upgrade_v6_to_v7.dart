import 'package:inspiral/database/schema.dart';
import 'package:sqflite/sqflite.dart';

Future<void> upgradeV6ToV7(Database db) async {
  var batch = db.batch();

  batch.execute('''
    ALTER TABLE ${Schema.state}
    ADD ${Schema.state.createSnapshotBeforeNextDraw} INTEGER CHECK(${Schema.state.createSnapshotBeforeNextDraw} IN (0, 1)) NOT NULL DEFAULT 0
  ''');

  await batch.commit(noResult: true);
}
