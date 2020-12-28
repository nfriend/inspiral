import 'package:flutter/material.dart';
import 'package:inspiral/models/base_gear_model.dart';
import 'package:inspiral/models/fixed_gear_model.dart';
import 'package:inspiral/models/gear_definition.dart';

class RotatingGearModel extends BaseGearModel {
  RotatingGearModel({
    @required Offset initialOffset,
    @required GearDefinition initialGearDefinition,
  }) : super(
            initialPosition: initialOffset,
            initialGearDefinition: initialGearDefinition);

  FixedGearModel fixedGear;

  fixedGearDrag(Offset rotatingGearDelta) {
    position -= rotatingGearDelta;
  }
}
