import 'package:flutter/material.dart';

class ContactPoint {
  ContactPoint({this.position, this.direction});

  /// The position of this contact point relative to the gear's center point
  Offset position;

  /// The "angle" of this contact point. This angle is relative to the gear's
  /// current orientation and indicates the "flatness" of the current spot.
  double direction;

  @override
  String toString() {
    return "ContactPoint(position: $position, direction: $direction)";
  }

  @override
  int get hashCode => position.hashCode ^ direction.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ContactPoint &&
      other.position == position &&
      other.direction == direction;
}
