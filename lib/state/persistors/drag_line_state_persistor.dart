import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/get_drag_line_state_for_version.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqlite_api.dart';

class DragLineStatePersistor {
  static void persist(Batch batch, DragLineState dragLine) {
    batch.update(
        Schema.state.toString(),
        {
          Schema.state.dragLinePositionX: dragLine.pivotPosition.dx,
          Schema.state.dragLinePositionY: dragLine.pivotPosition.dy,
          Schema.state.dragLineAngle: dragLine.angle
        },
        where: getWhereClauseForVersion(Schema.state.version, null));
  }

  static Future<DragLineStateSnapshot> rehydrate(
      Database db, DragLineState dragLine) async {
    return await getDragLineStateForVersion(null, dragLine.allStateObjects);
  }
}
