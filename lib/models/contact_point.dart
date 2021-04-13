import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:quiver/core.dart';
import 'package:tuple/tuple.dart';

@immutable
class ContactPoint {
  const ContactPoint({this.position, this.direction});

  /// The position of this contact point relative to the gear's center point
  final Offset position;

  /// The "angle" of this contact point. This angle is relative to the gear's
  /// current orientation and indicates the "flatness" of the current spot.
  final double direction;

  /// Returns a new ContactPoint, translated by the provided offset
  ContactPoint translated(Offset offset) {
    return ContactPoint(position: position + offset, direction: direction);
  }

  /// Returns a new ContactPoint, rotated by `angle` around the provided point
  /// Based on https://stackoverflow.com/a/2259502/1063392
  ContactPoint rotated(double angle, Offset point) {
    // Add the rotation to the new direction
    var rotatedDirection = (direction + angle + (2 * pi)) % (2 * pi);

    return ContactPoint(
        position: point.rotated(angle, point), direction: rotatedDirection);
  }

  @override
  String toString() {
    return 'ContactPoint(position: $position, direction: $direction)';
  }

  @override
  int get hashCode => hash2(position.hashCode, direction.hashCode);

  @override
  bool operator ==(Object other) =>
      other is ContactPoint &&
      other.position == position &&
      other.direction == direction;

  /// Computes the weighted averaged of a number of ContactPoints
  static ContactPoint weightedAverage(
      List<Tuple2<ContactPoint, double>> weightedPoints) {
    var averagedPosition = Offset.zero;
    var totalWeight = 0.0;

    // To compute the average direction, we treat each direction
    // as a vector with length `weight`, sum them all up, and
    // return the angle of the result.
    // See https://stackoverflow.com/a/491769/1063392.
    var totalDirectionX = 0.0;
    var totalDirectionY = 0.0;

    for (final point in weightedPoints) {
      averagedPosition += point.item1.position * point.item2;
      totalDirectionX += cos(point.item1.direction) * point.item2;
      totalDirectionY += sin(point.item1.direction) * point.item2;
      totalWeight += point.item2;
    }

    averagedPosition /= totalWeight;
    var averagedDirection = atan2(totalDirectionY, totalDirectionX);

    return ContactPoint(
        position: averagedPosition, direction: averagedDirection);
  }
}
