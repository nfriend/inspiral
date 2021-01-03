import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';

/// Convenience function to generate a gear definition for regular circle gear
GearDefinition generateCircleGearDefinition({int toothCount}) {
  double diameter = toothCount * 4 + 20.0;
  final size = Size(diameter, diameter);

  return GearDefinition(
      image: "images/gear_$toothCount.png",
      size: size,
      angleToTooth: (angle) {
        return (angle / (2 * pi)) * toothCount;
      },
      toothToContactPoint: (tooth) {
        double direction = (tooth / toothCount) * 2 * pi;
        return ContactPoint(
            position: Offset(
                    cos(direction) * toothCount, -sin(direction) * toothCount) *
                2,
            direction: direction);
      });
}

class GearDefinitions {
  static final circle24 = generateCircleGearDefinition(toothCount: 24);
  static final circle84 = generateCircleGearDefinition(toothCount: 84);

  static final defaultRotatingGear = GearDefinitions.circle24;
  static final defaultFixedGear = GearDefinitions.circle84;
}
