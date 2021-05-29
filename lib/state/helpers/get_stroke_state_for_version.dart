import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/stroke_style.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';

class StrokeStateSnapshot {
  final double width;
  final StrokeStyle style;

  StrokeStateSnapshot({required this.width, required this.style});
}

Future<StrokeStateSnapshot> getStrokeStateForVersion(int? version) async {
  final db = await getDatabase();

  final allRows = (await db.query(Schema.state.toString(),
      columns: [Schema.state.strokeStyle, Schema.state.strokeWidth],
      where: getWhereClauseForVersion(Schema.state.version, version)));

  if (allRows.isEmpty) {
    return StrokeStateSnapshot(
        width: defaultStrokeWidth, style: defaultStrokeStyle);
  } else {
    final state = allRows.first;

    return StrokeStateSnapshot(
        width: state[Schema.state.strokeWidth] as double,
        style: stringToStrokeStyle(state[Schema.state.strokeStyle] as String));
  }
}
