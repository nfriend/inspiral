import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';

class SnapPointsAndActivePoint {
  final Set<Offset> snapPoints;
  final Offset? activeSnapPoint;

  SnapPointsAndActivePoint(
      {required this.snapPoints, required this.activeSnapPoint});
}

Future<SnapPointsAndActivePoint> getSnapPointsForVersion(int? version) async {
  var db = await getDatabase();

  var snapPointRows = (await db.query(Schema.snapPoints.toString(),
      where: getWhereClauseForVersion(Schema.snapPoints.version, version)));

  var snapPoints = HashSet<Offset>();
  Offset? activeSnapPoint;
  for (var row in snapPointRows) {
    var point = Offset(
        row[Schema.snapPoints.x] as double, row[Schema.snapPoints.y] as double);
    snapPoints.add(point);

    var isActive = (row[Schema.snapPoints.isActive] as int).toBool();

    if (isActive) {
      activeSnapPoint = point;
    }
  }

  return SnapPointsAndActivePoint(
      snapPoints: snapPoints, activeSnapPoint: activeSnapPoint);
}
