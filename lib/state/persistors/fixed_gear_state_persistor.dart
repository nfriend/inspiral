import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/models/gears/gears.dart';
import 'package:inspiral/models/gears/oval_30.dart';
import 'package:inspiral/state/persistors/base_gear_state_rehydration_result.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:inspiral/extensions/extensions.dart';

class FixedGearStateRehydrationResult extends BaseGearStateRehydrationResult {
  final Offset position;

  FixedGearStateRehydrationResult(
      {@required GearDefinition definition,
      @required bool isVisible,
      @required this.position})
      : super(definition: definition, isVisible: isVisible);

  @override
  String toString() {
    return 'FixedGearStateRehydrationResult(position: $position, definition: $definition, isVisible: $isVisible)';
  }
}

class FixedGearStatePersistor {
  static void persist(Batch batch, FixedGearState fixedGear) {
    batch.update(Schema.state.toString(), {
      Schema.state.fixedGearPositionX: fixedGear.position.dx,
      Schema.state.fixedGearPositionY: fixedGear.position.dy,
      Schema.state.fixedGearDefinitionId: fixedGear.definition.id,
      Schema.state.gearsAreVisible: fixedGear.isVisible.toInt()
    });
  }

  static Future<FixedGearStateRehydrationResult> rehydrate(
      Database db, FixedGearState fixedGear) async {
    Map<String, dynamic> state =
        (await db.query(Schema.state.toString())).first;

    // Defaulting to oval30 just in case we didn't find a match in `allGears`.
    // This _should_ never happen.
    var definition =
        allGears[state[Schema.state.fixedGearDefinitionId]] ?? oval30;

    // If these are null, it means we don't have a previously-saved gear
    // position. (For example, when opening the app for the very first time.)
    // In this case, use `canvasCenter` instead.
    var positionX =
        state[Schema.state.fixedGearPositionX] as double ?? canvasCenter.dx;
    var positionY =
        state[Schema.state.fixedGearPositionY] as double ?? canvasCenter.dy;

    return FixedGearStateRehydrationResult(
        position: Offset(positionX, positionY),
        definition: definition,
        isVisible: (state[Schema.state.gearsAreVisible] as int).toBool());
  }
}
