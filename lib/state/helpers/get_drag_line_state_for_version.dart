import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
import 'package:inspiral/state/inspiral_state_object.dart';

class DragLineStateSnapshot {
  final Offset pivotPosition;
  final double angle;

  DragLineStateSnapshot({@required this.pivotPosition, @required this.angle});
}

Future<DragLineStateSnapshot> getDragLineStateForVersion(
    int version, AllStateObjects allStateObjects) async {
  var db = await getDatabase();

  var allRows = (await db.query(Schema.state.toString(),
      columns: [
        Schema.state.dragLinePositionX,
        Schema.state.dragLinePositionY,
        Schema.state.dragLineAngle
      ],
      where: getWhereClauseForVersion(Schema.state.version, version)));

  // If we don't have a previously-saved pivot position (for example, when
  // opening the app for the first time), use `canvasCenter` instead.
  var defaultPivotPosition = Offset(allStateObjects.canvas.canvasCenter.dx,
      allStateObjects.canvas.canvasCenter.dy);

  if (allRows.isEmpty) {
    return DragLineStateSnapshot(
        pivotPosition: defaultPivotPosition, angle: rotatingGearStartingAngle);
  } else {
    var state = allRows.first;

    var positionX = state[Schema.state.dragLinePositionX] as double ??
        defaultPivotPosition.dx;
    var positionY = state[Schema.state.dragLinePositionY] as double ??
        defaultPivotPosition.dy;

    return DragLineStateSnapshot(
        pivotPosition: Offset(positionX, positionY),
        angle: state[Schema.state.dragLineAngle] as double);
  }
}
