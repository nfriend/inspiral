import 'package:inspiral/constants.dart';
import 'package:inspiral/database/schema.dart';
import 'package:sqflite/sqflite.dart';

Future<void> upgradeV7ToV8(Database db) async {
  var batch = db.batch();

  batch.execute('''
    ALTER TABLE ${Schema.state}
    ADD ${Schema.state.rotatingGearToothOffset} INTEGER NOT NULL DEFAULT $defaultRotatingGearToothOffset
  ''');

  await batch.commit(noResult: true);
}
