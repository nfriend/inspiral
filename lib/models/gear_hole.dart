import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:quiver/core.dart';

class GearHole {
  /// The name of this hole that uniquely identifies it within the gear
  final String name;

  /// The angle, in radians, of this hole relative to the gear's center
  final double angle;

  /// The distance of this hole from the gear's center, in logical pixels
  final double distance;

  const GearHole(
      {@required this.name, @required this.angle, @required this.distance});

  // The relative offset from the gear
  Offset get relativeOffset {
    return Offset(cos(angle), -sin(angle)) * distance * scaleFactor;
  }

  @override
  bool operator ==(Object other) =>
      other is GearHole &&
      other.name == name &&
      other.angle == angle &&
      other.distance == distance;

  @override
  int get hashCode => hash3(name.hashCode, angle.hashCode, distance.hashCode);
}
