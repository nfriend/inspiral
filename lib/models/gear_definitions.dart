import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';

/// Convenience function to get the Size parameter for circle gears
Size getSizeForCircle({int toothCount}) {
  double diameter = toothCount * 4 + 20.0;
  return Size(diameter, diameter);
}

/// Convenience function to get the angleToTooth function for circle gears
double Function(double) getAngleToToothForCircle({int toothCount}) {
  return (angle) {
    return (angle / (2 * pi)) * 24;
  };
}

/// Convenience function to get the toothToContactPoint function for
/// circle gears
ContactPoint Function(double) getToothToContactPointForCircle(
    {int toothCount}) {
  return (tooth) {
    double direction = (tooth / 24) * 2 * pi;
    return ContactPoint(
        position: Offset(cos(direction) * 24, sin(direction) * 24),
        direction: direction);
  };
}

class GearDefinitions {
  static final circle24 = GearDefinition(
      image: 'images/gear_24.png',
      size: getSizeForCircle(toothCount: 24),
      angleToTooth: getAngleToToothForCircle(toothCount: 24),
      toothToContactPoint: getToothToContactPointForCircle(toothCount: 24));

  static final circle84 = GearDefinition(
      image: 'images/gear_84.png',
      size: getSizeForCircle(toothCount: 84),
      angleToTooth: getAngleToToothForCircle(toothCount: 84),
      toothToContactPoint: getToothToContactPointForCircle(toothCount: 84));

  static final defaultRotatingGear = GearDefinitions.circle24;
  static final defaultFixedGear = GearDefinitions.circle84;
}
