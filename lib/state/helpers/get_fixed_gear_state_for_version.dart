import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/gears/gears.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
import 'package:inspiral/state/inspiral_state_object.dart';
import 'package:inspiral/extensions/extensions.dart';

class FixedGearStateSnapshot {
  GearDefinition definition;
  bool isVisible;
  Offset position;
  double/*!*/ rotation;
  bool isLocked;

  FixedGearStateSnapshot(
      {@required this.definition,
      @required this.isVisible,
      @required this.position,
      @required this.rotation,
      @required this.isLocked});
}

Future<FixedGearStateSnapshot> getFixedGearStateForVersion(
    int/*?*/ version, AllStateObjects allStateObjects) async {
  var db = await getDatabase();

  var allRows = (await db.query(Schema.state.toString(),
      columns: [
        Schema.state.fixedGearDefinitionId,
        Schema.state.fixedGearPositionX,
        Schema.state.fixedGearPositionY,
        Schema.state.fixedGearRotation,
        Schema.state.fixedGearIsLocked,
        Schema.state.gearsAreVisible
      ],
      where: getWhereClauseForVersion(Schema.state.version, version)));

  // If we don't have a previously-saved position (for example, when
  // opening the app for the first time), use `canvasCenter` instead.
  var defaultPosition = Offset(allStateObjects.canvas.canvasCenter.dx,
      allStateObjects.canvas.canvasCenter.dy);

  if (allRows.isEmpty) {
    return FixedGearStateSnapshot(
        position: defaultPosition,
        definition: defaultFixedGear,
        isVisible: defaultGearVisibility,
        isLocked: defaultFixedGearLocked,
        rotation: fixedGearStartingRotation);
  } else {
    var state = allRows.first;

    // Defaulting to circle96Ring just in case we didn't find a match in `allGears`.
    // This _should_ never happen.
    var definition =
        allGears[state[Schema.state.fixedGearDefinitionId]] ?? defaultFixedGear;

    // If these are null, it means we don't have a previously-saved gear
    // position. (For example, when opening the app for the very first time.)
    // In this case, use `canvasCenter` instead.
    var positionX =
        state[Schema.state.fixedGearPositionX] as double ?? defaultPosition.dx;
    var positionY =
        state[Schema.state.fixedGearPositionY] as double ?? defaultPosition.dy;

    return FixedGearStateSnapshot(
        position: Offset(positionX, positionY),
        definition: definition,
        isVisible: (state[Schema.state.gearsAreVisible] as int).toBool(),
        isLocked: (state[Schema.state.fixedGearIsLocked] as int).toBool(),
        rotation: state[Schema.state.fixedGearRotation] as double/*!*/);
  }
}
