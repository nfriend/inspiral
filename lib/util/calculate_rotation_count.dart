import 'package:flutter/material.dart';

/// Calculates the number of rotations necessary to draw a complete design,
/// given a fixed gear and a rotating gear
int calculateRotationCount(
    {@required int fixedGearTeeth,
    @required int rotatingGearTeeth,
    @required double selectedHoleDistance}) {
  if (selectedHoleDistance < 0.0001) {
    return 1;
  }

  var lcm = fixedGearTeeth *
      rotatingGearTeeth ~/
      fixedGearTeeth.gcd(rotatingGearTeeth);

  return lcm ~/ fixedGearTeeth;
}
