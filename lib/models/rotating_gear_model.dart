import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';

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
