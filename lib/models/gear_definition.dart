import 'dart:math';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';

@immutable
class GearDefinition {
  /// The asset path to the gear's image
  final String image;

  /// The size of the gear, in logical pixels
  final Size size;

  /// The number of teeth on this gear
  final int toothCount;

  /// The points that define the shape of this gear
  final List<ContactPoint> points;

  GearDefinition(
      {@required this.image,
      @required this.size,
      @required this.toothCount,
      @required this.points});

  double angleToTooth(double angle) {
    return (angle / (2 * pi)) * toothCount;
  }

  ContactPoint toothToContactPoint(double tooth, {bool isRotating = false}) {
    // Rotating gears with an even number of teeth also need to be offset
    // by half a tooth in order to mesh with the fixed gear
    if (isRotating && toothCount % 2 == 0) {
      tooth += .5;
    }

    int contactPointIndex =
        (points.length * (tooth / toothCount)).round() % (points.length - 1);

    // Rotating gears "spin" in the opposite direction as fixed gears,
    // so need to search through the list of points backwards
    if (isRotating) {
      contactPointIndex = (-1 * contactPointIndex) + (points.length - 1);
    }

    ContactPoint point = points[contactPointIndex];

    // print("${isRotating ? "Rotating gear:" : "Fixed gear:"} $point");

    return point;
  }

  // ContactPoint toothToContactPointOld(double tooth, {bool isRotating = false}) {
  //   // Rotating gears "spin" in the opposite direction as fixed gears
  //   double conditionalReversal = isRotating ? -1 : 1;

  //   double conditionalExtraRotation = 0;

  //   if (isRotating) {
  //     // Rotating gears need to be rotated a full half rotation relative to
  //     // fixed gears
  //     conditionalExtraRotation += pi;

  //     // Rotating gears with an even number of teeth also need to be offset
  //     // by half a tooth in order to mesh with the fixed gear
  //     double radiansPerTooth = (2 * pi) / toothCount;
  //     conditionalExtraRotation += radiansPerTooth / 2;
  //   }

  //   double direction =
  //       ((tooth / toothCount) * 2 * pi + conditionalExtraRotation) *
  //           conditionalReversal;
  //   return ContactPoint(
  //       position: Offset(cos(direction) * (toothCount + meshSpacing / 2),
  //               -sin(direction) * (toothCount + meshSpacing / 2)) *
  //           scaleFactor,
  //       direction: direction);
  // }

  ContactPoint angleToContactPoint(double angle) {
    return toothToContactPoint(angleToTooth(angle));
  }

  @override
  int get hashCode =>
      image.hashCode ^
      size.hashCode ^
      angleToTooth.hashCode ^
      toothToContactPoint.hashCode;

  @override
  bool operator ==(Object other) =>
      other is GearDefinition &&
      other.image == image &&
      other.size == size &&
      other.angleToTooth == angleToTooth &&
      other.toothToContactPoint == toothToContactPoint;
}
