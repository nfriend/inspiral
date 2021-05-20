import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

Future<void> snapshotVersionedTables(Batch batch, int version) async {
  var db = await getDatabase();

  final state = (await db.query(Schema.state.toString(),
          where: getWhereClauseForVersion(Schema.state.version, null)))
      .first;
  final colorRows = (await db.query(Schema.colors.toString(),
      where: getWhereClauseForVersion(Schema.colors.version, null)));

  String selectedPenId;
  String lastSelectedPenId;
  String selectedCanvasColorId;
  String lastSelectedCanvasColorId;
  for (var colorRow in colorRows) {
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
    } else if (oldId == state[Schema.state.lastSelectedCanvasColor] as String) {
      lastSelectedCanvasColorId = newId;
    }

    batch.insert(Schema.colors.toString(), colorRowClone);
  }

  var stateClone = Map<String, Object>.from(state);
  stateClone[Schema.state.selectedPenColor] = selectedPenId;
  stateClone[Schema.state.selectedCanvasColor] = selectedCanvasColorId;
  stateClone[Schema.state.lastSelectedPenColor] = lastSelectedPenId;
  stateClone[Schema.state.lastSelectedCanvasColor] = lastSelectedCanvasColorId;
  stateClone[Schema.state.version] = version;

  batch.insert(Schema.state.toString(), stateClone);
}
