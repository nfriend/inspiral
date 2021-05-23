import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/snapshot_versioned_tables.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

Future<void> upgradeV5ToV6(Database db) async {
  var batch = db.batch();

  batch.execute('''
    ALTER TABLE ${Schema.colors}
    ADD ${Schema.colors.version} INTEGER NULL
  ''');

  batch.execute('''
    ALTER TABLE ${Schema.state}
    ADD ${Schema.state.version} INTEGER NULL
  ''');

  await batch.commit(noResult: true);

  // Since we don't have an undo history for the colors or state, backfill the
  // undo stack with identical copies of the current state as a temporary
  // measure.
  final state = (await db.query(Schema.state.toString())).first;
  batch = db.batch();
  final currentVersion = state[Schema.state.currentSnapshotVersion] as int;
  for (var version = 0; version < currentVersion; version++) {
    await snapshotVersionedTables(batch, version, database: db);
  }
  await batch.commit(noResult: true);
}
