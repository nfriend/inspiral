import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/get_snap_points_for_version.dart';
import 'package:inspiral/state/snap_point_state.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:inspiral/extensions/extensions.dart';

const Uuid _uuid = Uuid();

class SnapPointStateUndoer {
  static Future<void> cleanUpOldRedoSnapshots(int version, Batch batch) async {
    batch.delete(Schema.snapPoints.toString(),
        where: '${Schema.snapPoints.version} >= $version');
  }

  static Future<void> snapshot(
      int version, Batch batch, SnapPointState snapPointState) async {
    for (var point in snapPointState.snapPoints) {
      batch.insert(Schema.snapPoints.toString(), {
        Schema.snapPoints.id: _uuid.v4(),
        Schema.snapPoints.x: point.dx,
        Schema.snapPoints.y: point.dy,
        Schema.snapPoints.isActive:
            (point == snapPointState.activeSnapPoint).toInt(),
        Schema.snapPoints.version: version
      });
    }
  }

  static Future<SnapPointsAndActivePoint> undo(
      int/*!*/ version, SnapPointState snapPointState) async {
    return await getSnapPointsForVersion(version);
  }

  static Future<SnapPointsAndActivePoint> redo(
      int/*!*/ version, SnapPointState snapPointState) async {
    return await getSnapPointsForVersion(version);
  }
}
