import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/gears/gears.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
import 'package:inspiral/extensions/extensions.dart';

class RotatingGearStateSnapshot {
  double angle;
  GearHole activeHole;
  GearDefinition definition;
  bool isVisible;

  RotatingGearStateSnapshot(
      {@required this.angle,
      @required this.activeHole,
      @required this.definition,
      @required this.isVisible});
}

Future<RotatingGearStateSnapshot> getRotatingGearStateForVersion(
    int version) async {
  var db = await getDatabase();

  var allRows = (await db.query(Schema.state.toString(),
      columns: [
        Schema.state.rotatingGearAngle,
        Schema.state.rotatingGearActiveHoleName,
        Schema.state.rotatingGearDefinitionId,
        Schema.state.gearsAreVisible
      ],
      where: getWhereClauseForVersion(Schema.state.version, version)));

  if (allRows.isEmpty) {
    return RotatingGearStateSnapshot(
        angle: rotatingGearStartingAngle,
        definition: defaultRotatingGear,
        activeHole: defaultActiveHole,
        isVisible: defaultGearVisibility);
  } else {
    var state = allRows.first;

    // Defaulting here just in case we didn't find a match in `allGears`.
    // This _should_ never happen.
    var definition = allGears[state[Schema.state.rotatingGearDefinitionId]] ??
        defaultRotatingGear;

    return RotatingGearStateSnapshot(
        angle: state[Schema.state.rotatingGearAngle] as double,
        definition: definition,
        isVisible: (state[Schema.state.gearsAreVisible] as int).toBool(),
        activeHole: definition.holes.firstWhere(
            (h) => h.name == state[Schema.state.rotatingGearActiveHoleName],
            orElse: () => definition.holes.last));
  }
}
