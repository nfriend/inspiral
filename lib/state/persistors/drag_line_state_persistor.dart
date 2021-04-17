import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqlite_api.dart';

class DragLineStateRehydrationResult {
  final Offset pivotPosition;
  final double angle;

  DragLineStateRehydrationResult(
      {@required this.pivotPosition, @required this.angle});
}

class DragLineStatePersistor {
  static void persist(Batch batch, DragLineState dragLine) {
    batch.update(Schema.state.toString(), {
      Schema.state.dragLinePositionX: dragLine.pivotPosition.dx,
      Schema.state.dragLinePositionY: dragLine.pivotPosition.dy,
      Schema.state.dragLineAngle: dragLine.angle
    });
  }

  static Future<DragLineStateRehydrationResult> rehydrate(
      Database db, DragLineState dragLine) async {
    Map<String, dynamic> state =
        (await db.query(Schema.state.toString())).first;

    // If these are null, it means we don't have a previously-saved pivot
    // position. (For example, when opening the app for the very first time.)
    // In this case, use `canvasCenter` instead.
    var positionX = state[Schema.state.dragLinePositionX] as double ??
        dragLine.canvas.canvasCenter.dx;
    var positionY = state[Schema.state.dragLinePositionY] as double ??
        dragLine.canvas.canvasCenter.dy;

    return DragLineStateRehydrationResult(
        pivotPosition: Offset(positionX, positionY),
        angle: state[Schema.state.dragLineAngle] as double);
  }
}
