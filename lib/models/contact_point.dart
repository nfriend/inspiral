import 'package:flutter/material.dart';

@immutable
class ContactPoint {
  ContactPoint({this.position, this.direction});

  /// The position of this contact point relative to the gear's center point
  final Offset position;

  /// The "angle" of this contact point. This angle is relative to the gear's
  /// current orientation and indicates the "flatness" of the current spot.
  final double direction;

  /// Returns a new ContactPoint, translated by the provided offset
  ContactPoint translated(Offset offset) {
    return ContactPoint(position: position + offset, direction: direction);
  }

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
