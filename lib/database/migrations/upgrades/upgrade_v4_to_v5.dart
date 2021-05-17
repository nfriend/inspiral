import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/auto_draw_speed.dart';
import 'package:sqflite/sqflite.dart';

Future<void> upgradeV4ToV5(Database db) async {
  var batch = db.batch();

  batch.execute('''
    ALTER TABLE ${Schema.state}
    ADD ${Schema.state.autoDrawSpeed} TEXT NOT NULL DEFAULT '${AutoDrawSpeed.slow}'
  ''');

  await batch.commit(noResult: true);
}
