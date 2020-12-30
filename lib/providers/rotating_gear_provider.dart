import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/providers/providers.dart';

class RotatingGearProvider extends BaseGearProvider {
  RotatingGearProvider({
    @required Offset initialOffset,
    @required GearDefinition initialGearDefinition,
  }) : super(
            initialPosition: initialOffset,
            initialGearDefinition: initialGearDefinition);

  FixedGearProvider fixedGear;

  fixedGearDrag(Offset rotatingGearDelta) {
    position -= rotatingGearDelta;
  }
}
