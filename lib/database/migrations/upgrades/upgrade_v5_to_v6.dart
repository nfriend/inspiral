import 'package:inspiral/database/schema.dart';
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
  final state = (await db.query(Schema.state.toString()))[0];
  final colorsRows = (await db.query(Schema.colors.toString()));

  batch = db.batch();

  final currentVersion = state[Schema.state.currentSnapshotVersion] as int;
  for (var version = 0; version < currentVersion; version++) {
    String selectedPenId;
    String lastSelectedPenId;
    String selectedCanvasColorId;
    String lastSelectedCanvasColorId;

    for (var colorRow in colorsRows) {
      var oldId = colorRow[Schema.colors.id] as String;

      var colorRowClone = Map<String, Object>.from(colorRow);
      var newId = _uuid.v4();
      colorRowClone[Schema.colors.id] = newId;
      colorRowClone[Schema.colors.version] = version;

      if (oldId == state[Schema.state.selectedPenColor] as String) {
        selectedPenId = newId;
      } else if (oldId == state[Schema.state.selectedCanvasColor] as String) {
        selectedCanvasColorId = newId;
      } else if (oldId == state[Schema.state.lastSelectedPenColor] as String) {
        lastSelectedPenId = newId;
      } else if (oldId ==
          state[Schema.state.lastSelectedCanvasColor] as String) {
        lastSelectedCanvasColorId = newId;
      }

      batch.insert(Schema.colors.toString(), colorRowClone);
    }

    var stateClone = Map<String, Object>.from(state);
    stateClone[Schema.state.selectedPenColor] = selectedPenId;
    stateClone[Schema.state.selectedCanvasColor] = selectedCanvasColorId;
    stateClone[Schema.state.lastSelectedPenColor] = lastSelectedPenId;
    stateClone[Schema.state.lastSelectedCanvasColor] =
        lastSelectedCanvasColorId;
    stateClone[Schema.state.currentSnapshotVersion] = version;
    stateClone[Schema.state.version] = version;

    batch.insert(Schema.state.toString(), stateClone);
  }

  await batch.commit(noResult: true);
}
