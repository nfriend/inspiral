import 'dart:math';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:tuple/tuple.dart';

@immutable
class GearDefinition {
  /// An ID that uniquely identifies this gear definition
  final String id;

  /// The asset path to the gear's image
  final String image;

  /// The asset path to the gear's thumbnail image
  final String thumbnailImage;

  /// The size of the gear, in logical pixels
  final Size size;

  /// The center point of the gear, in logical pixels,
  /// relative to the top-left cornef of the gear's image.
  final Offset center;

  /// The number of teeth on this gear
  final int toothCount;

  /// The points that define the shape of this gear
  final List<ContactPoint> points;

  /// The list of all holes in this gear
  final List<GearHole> holes;

  /// Whether or not this gear is a ring gear (i.e. its teeth
  /// appear on the inside of the gear.)
  final bool isRing;

  /// Whether or not this gear is perfect round
  final bool isRound;

  /// The smallest angle difference in a convex direction between
  /// any two consecutive teeth on this gear.
  final double smallestConvexDiff;

  /// The biggest angle difference in a convex direction between
  /// any two consecutive teeth on this gear.
  final double biggestConvexDiff;

  /// The smallest angle difference in a concave direction between
  /// any two consecutive teeth on this gear.
  final double smallestConcaveDiff;

  /// The biggest angle difference in a concave direction between
  /// any two consecutive teeth on this gear.
  final double biggestConcaveDiff;

  /// The entitlement that includes this gear
  final String entitlement;

  /// The package that will unlock the gear's entitlement
  final String package;

  GearDefinition(
      {@required this.id,
      @required this.image,
      @required this.thumbnailImage,
      @required this.size,
      @required this.center,
      @required this.toothCount,
      @required this.points,
      @required this.holes,
      @required this.isRing,
      @required this.isRound,
      @required this.entitlement,
      @required this.package,
      @required this.smallestConvexDiff,
      @required this.biggestConvexDiff,
      @required this.smallestConcaveDiff,
      @required this.biggestConcaveDiff});

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
    var contactPointIndexUnrounded = points.length * (tooth / toothCount);

    // Find the two closest ContactPoints
    // Note: These two indices will usually be different (offset by 1),
    // _except_ if `contactPointIndexUnrounded` exactly equals an integer.
    var contactPointLowerIndex =
        contactPointIndexUnrounded.floor() % points.length;
    var contactPointUpperIndex =
        contactPointIndexUnrounded.ceil() % points.length;

    // Rotating gears "spin" in the opposite direction as fixed gears,
    // so need to search through the list of points backwards
    if (isRotating) {
      contactPointLowerIndex = -contactPointLowerIndex % points.length;
      contactPointUpperIndex = -contactPointUpperIndex % points.length;
    }

    // Perform a weighted average of the two ContactPoints
    // to get our final ContactPoint
    var lowerPoint = points[contactPointLowerIndex];
    var upperPoint = points[contactPointUpperIndex];

    // Find the weight that should be applied to each point.
    // For example, if `contactPointIndexUnrounded` is 12.25,
    // we want ContactPoint[12] to be heavier weighted (.75, to be exact),
    // than ContactPoint[13] (.25).
    var lowerWeight =
        contactPointIndexUnrounded.ceil() - contactPointIndexUnrounded;
    var upperWeight = 1 - lowerWeight;

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
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is GearDefinition && other.id == id;
}
