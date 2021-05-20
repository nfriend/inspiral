import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/snapshot_versioned_tables.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/helpers/persist_all_state_objects.dart';
import 'package:sqflite/sqflite.dart';

// Even though it's not a perfect match, this undoer is in charge
// of snapshotting the main "state" table. It doesn't make sense for each
// state object to try and snapshot its _portion_ of the row individually,
// even though this would be logically more consistent. It's much simpler
// to clone the current row in one place.
class UndoRedoStateUndoer {
  static Future<void> snapshot(
      int version, Batch batch, AllStateObjects allStateObjects) async {
    assert(version != null, 'version should not be null in a snapshot!');

    // First, persist all state objects to the database, so that the `state`
    // table reflects the current stat of the app.
    await persistAllStateObjects(allStateObjects);

    await snapshotVersionedTables(batch, version);
  }

  static Future<void> cleanUpOldRedoSnapshots(int version, Batch batch) async {
    // Delete all snapshot records that are no longer relevant
    batch.delete(Schema.state.toString(),
        where: '${Schema.state.version} >= $version');
  }
}
