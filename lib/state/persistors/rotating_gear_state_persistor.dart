import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/gears/gears.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/persistors/base_gear_state_rehydration_result.dart';
import 'package:inspiral/state/rotating_gear_state.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:sqflite/sqlite_api.dart';

class RotatingGearStateRehydrationResult
    extends BaseGearStateRehydrationResult {
  final GearHole activeHole;
  final double angle;

  RotatingGearStateRehydrationResult(
      {@required GearDefinition definition,
      @required bool isVisible,
      @required this.activeHole,
      @required this.angle})
      : super(definition: definition, isVisible: isVisible);

  @override
  String toString() {
    return "RotatingGearStateRehydrationResult(angle: $angle, definition: $definition, isVisible: $isVisible, activeHole: $activeHole)";
  }
}

class RotatingGearStatePersistor {
  static void persist(Batch batch, RotatingGearState rotatingGear) {
    batch.update(Schema.state.toString(), {
      Schema.state.rotatingGearAngle: rotatingGear.lastAngle,
      Schema.state.rotatingGearDefinitionId: rotatingGear.definition.id,
      Schema.state.rotatingGearActiveHoleName: rotatingGear.activeHole.name,
      Schema.state.gearsAreVisible: rotatingGear.isVisible.toInt(),
    });
  }

  static Future<RotatingGearStateRehydrationResult> rehydrate(
      Database db, RotatingGearState rotatingGear) async {
    Map<String, dynamic> state =
        (await db.query(Schema.state.toString())).first;

    // Defaulting to circle24 just in case we didn't find a match in `allGears`.
    // This _should_ never happen.
    GearDefinition definition =
        allGears[state[Schema.state.rotatingGearDefinitionId]] ?? circle24;

    return RotatingGearStateRehydrationResult(
        angle: state[Schema.state.rotatingGearAngle],
        definition: definition,
        isVisible: (state[Schema.state.gearsAreVisible] as int).toBool(),
        activeHole: definition.holes.firstWhere(
            (h) => h.name == state[Schema.state.rotatingGearActiveHoleName],
            orElse: () => definition.holes.last));
  }
}
