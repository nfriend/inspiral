import 'dart:math';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:inspiral/models/gear_hole.dart';
import 'package:inspiral/models/models.dart';
import 'package:quiver/core.dart';
import 'package:tuple/tuple.dart';

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

  /// The list of all holes in this gear
  final List<GearHole> holes;

  GearDefinition(
      {@required this.image,
      @required this.size,
      @required this.toothCount,
      @required this.points,
      @required this.holes});

  /// Returns the gear's tooth at the provided angle
  double angleToTooth(double angle) {
    return (angle / (2 * pi)) * toothCount;
  }

  // Returns the "contact point" - i.e. the position and normal line - of the
  // gear at the provided tooth.
  ContactPoint toothToContactPoint(double tooth, {bool isRotating = false}) {
    // Rotating gears need to be offset by half a tooth
    // in order to mesh with the fixed gear
    if (isRotating) {
      tooth += 0.5;
    }

    // Make sure tooth is always in range of [0, toothCount)
    // This works even when tooth is negative.
    tooth = tooth % toothCount;

    // This represents the "unrounded" index that we should
    // select from the array.
    double contactPointIndexUnrounded = points.length * (tooth / toothCount);

    // Find the two closest ContactPoints
    // Note: These two indices will usually be different (offset by 1),
    // _except_ if `contactPointIndexUnrounded` exactly equals an integer.
    int contactPointLowerIndex =
        contactPointIndexUnrounded.floor() % points.length;
    int contactPointUpperIndex =
        contactPointIndexUnrounded.ceil() % points.length;

    // Rotating gears "spin" in the opposite direction as fixed gears,
    // so need to search through the list of points backwards
    if (isRotating) {
      contactPointLowerIndex = -contactPointLowerIndex % points.length;
      contactPointUpperIndex = -contactPointUpperIndex % points.length;
    }

    // Perform a weighted average of the two ContactPoints
    // to get our final ContactPoint
    ContactPoint lowerPoint = points[contactPointLowerIndex];
    ContactPoint upperPoint = points[contactPointUpperIndex];

    // Find the weight that should be applied to each point.
    // For example, if `contactPointIndexUnrounded` is 12.25,
    // we want ContactPoint[12] to be heavier weighted (.75, to be exact),
    // than ContactPoint[13] (.25).
    double lowerWeight =
        contactPointIndexUnrounded.ceil() - contactPointIndexUnrounded;
    double upperWeight = 1 - lowerWeight;

    return ContactPoint.weightedAverage([
      Tuple2<ContactPoint, double>(lowerPoint, lowerWeight),
      Tuple2<ContactPoint, double>(upperPoint, upperWeight)
    ]);
  }

  /// Returns the "contact point" for the provided angle
  ContactPoint angleToContactPoint(double angle) {
    return toothToContactPoint(angleToTooth(angle));
  }

  @override
  int get hashCode => hash4(image.hashCode, size.hashCode,
      angleToTooth.hashCode, toothToContactPoint.hashCode);

  @override
  bool operator ==(Object other) =>
      other is GearDefinition &&
      other.image == image &&
      other.size == size &&
      other.angleToTooth == angleToTooth &&
      other.toothToContactPoint == toothToContactPoint;
}
