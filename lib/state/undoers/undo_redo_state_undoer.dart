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
// In addition, this undoer is in charge of snapshotting the "colors" table,
// since the "state" table has foreign key references into this table.
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

    // Delete all color snapshots that are no longer relevant.
    // Also delete any historical color records that aren't referenced
    // by any other table. The full list of colors doesn't need to
    // be included in the snapshot, so this saves some disk space by removing
    // unnecessary color rows.
    // Note: if future tables are added that reference the color table by ID,
    // they will need to be taken into account in the subquery below.
    batch.rawDelete('''
      DELETE FROM ${Schema.colors}
      WHERE
        ${Schema.colors.version} >= $version OR (
          ${Schema.colors.version} IS NOT NULL
          AND NOT EXISTS (
            SELECT 1
            FROM ${Schema.state} s
            WHERE
              s.${Schema.state.selectedPenColor} == ${Schema.colors.id} OR
              s.${Schema.state.selectedCanvasColor} == ${Schema.colors.id} OR
              s.${Schema.state.lastSelectedPenColor} == ${Schema.colors.id} OR
              s.${Schema.state.lastSelectedCanvasColor} == ${Schema.colors.id}
          )
          AND NOT EXISTS (
            SELECT 1
            FROM ${Schema.inkLines} il
            WHERE
              il.${Schema.inkLines.colorId} == ${Schema.colors.id}
          )
        )
    ''');
  }
}
