import 'package:flutter/material.dart';
import 'package:inspiral/models/base_gear_model.dart';
import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/models/rotating_gear_model.dart';

class FixedGearModel extends BaseGearModel {
  FixedGearModel(
      {@required Offset initialOffset,
      @required GearDefinition initialGearDefinition})
      : super(
            initialOffset: initialOffset,
            initialGearDefinition: initialGearDefinition);

  RotatingGearModel rotatingGear;

  rotatingGearDrag(Offset rotatingGearDelta) {
    offset -= rotatingGearDelta;
  }
}
