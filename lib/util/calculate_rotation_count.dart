import 'package:flutter/material.dart';

/// Calculates the number of rotations necessary to draw a complete design,
/// given a fixed gear and a rotating gear
int calculateRotationCount(
    {@required int fixedGearTeeth, @required int rotatingGearTeeth}) {
  var lcm = fixedGearTeeth *
      rotatingGearTeeth ~/
      fixedGearTeeth.gcd(rotatingGearTeeth);

  return lcm ~/ fixedGearTeeth;
}
