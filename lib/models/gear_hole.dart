import 'package:flutter/material.dart';

class GearHole {
  /// The name of this hole that uniquely identifies it within the gear
  final String name;

  /// The angle, in radians, of this hole relative to the gear's center
  final double angle;

  /// The distance of this hole from the gear's center, in logical pixels
  final double distance;

  const GearHole(
      {@required this.name, @required this.angle, @required this.distance});
}
