import 'package:flutter/material.dart';
import 'package:inspiral/models/gear_definition.dart';

/// Determines if two gears are compatible (i.e. they will not overlap
/// in physically impossible ways).
bool areGearsCompatible(
    {@required GearDefinition fixedGear,
    @required GearDefinition rotatingGear}) {
  return fixedGear.biggestConcaveDiff <= rotatingGear.smallestConvexDiff &&
      rotatingGear.biggestConcaveDiff <= fixedGear.smallestConvexDiff;
}
