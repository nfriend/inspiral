import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/models.dart';

/// Convenience function to generate a gear definition for regular circle gear
GearDefinition generateCircleGearDefinition({int toothCount}) {
  double diameter = (toothCount + toothLength) * 2 * scaleFactor;
  final size = Size(diameter, diameter);

  return GearDefinition(
      image: "images/gear_$toothCount.png",
      size: size,
      angleToTooth: (angle) {
        return (angle / (2 * pi)) * toothCount;
      },
      toothToContactPoint: (tooth, {isRotating = false}) {
        // Rotating gears "spin" in the opposite direction as fixed gears
        double conditionalReversal = isRotating ? -1 : 1;

        double conditionalExtraRotation = 0;

        if (isRotating) {
          // Rotating gears need to be rotated a full half rotation relative to
          // fixed gears
          conditionalExtraRotation += pi;

          // Rotating gears with an even number of teeth also need to be offset
          // by half a tooth in order to mesh with the fixed gear
          double radiansPerTooth = (2 * pi) / toothCount;
          conditionalExtraRotation += radiansPerTooth / 2;
        }

        double direction =
            ((tooth / toothCount) * 2 * pi + conditionalExtraRotation) *
                conditionalReversal;
        return ContactPoint(
            position: Offset(cos(direction) * (toothCount + meshSpacing / 2),
                    -sin(direction) * (toothCount + meshSpacing / 2)) *
                scaleFactor,
            direction: direction);
      });
}

class GearDefinitions {
  static final circle24 = generateCircleGearDefinition(toothCount: 24);
  static final circle84 = generateCircleGearDefinition(toothCount: 84);

  static final defaultRotatingGear = GearDefinitions.circle24;
  static final defaultFixedGear = GearDefinitions.circle84;
}
