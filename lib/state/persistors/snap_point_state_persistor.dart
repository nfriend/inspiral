import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/get_snap_points_for_version.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqflite.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:uuid/uuid.dart';

class SnapPointStateRehydrationResult {
  final Set<Offset> snapPoints;
  final Offset activeSnapPoint;
  final bool areActive;

  SnapPointStateRehydrationResult(
      {@required this.snapPoints,
      @required this.activeSnapPoint,
      @required this.areActive});
}

class SnapPointStatePersistor {
  static void persist(Batch batch, SnapPointState snapPointState) {
    var uuid = Uuid();

    // Delete all the snap points with version == null.
    // Snap points with a null version indicated are
    // the "current" snap points (i.e. not associated with
    // an undo state).
    batch.delete(Schema.snapPoints.toString(),
        where: getWhereClauseForVersion(Schema.snapPoints.version, null));

    for (var point in snapPointState.snapPoints) {
      batch.insert(Schema.snapPoints.toString(), {
        Schema.snapPoints.id: uuid.v4(),
        Schema.snapPoints.x: point.dx,
        Schema.snapPoints.y: point.dy,
        Schema.snapPoints.isActive:
            (point == snapPointState.activeSnapPoint).toInt(),
        Schema.snapPoints.version: null
      });
    }

    batch.update(Schema.state.toString(),
        {Schema.state.snapPointsAreActive: snapPointState.areActive.toInt()});
  }

  static Future<SnapPointStateRehydrationResult> rehydrate(
    Database db,
  ) async {
    var pointsAndActive = await getSnapPointsForVersion(null);

    Map<String, dynamic> state = (await db.query(Schema.state.toString(),
            columns: [Schema.state.snapPointsAreActive],
            where: getWhereClauseForVersion(Schema.state.version, null)))
        .first;

    var areActive = (state[Schema.state.snapPointsAreActive] as int).toBool();

    return SnapPointStateRehydrationResult(
        snapPoints: pointsAndActive.snapPoints,
        activeSnapPoint: pointsAndActive.activeSnapPoint,
        areActive: areActive);
  }
}
