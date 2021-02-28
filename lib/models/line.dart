import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class Line {
  Line(this.point1, this.point2);

  final Offset point1;
  final Offset point2;

  /// The angle of this line, in radians
  double angle() {
    return atan2(point2.dy - point1.dy, point2.dx - point1.dx);
  }

  /// The length of this line
  double length() {
    return (point2 - point1).distance;
  }

  /// The angle between this line and another
  double angleTo(Line other) {
    return (other.angle() - angle() + pi) % (2 * pi) - pi;
  }

  /// The point exactly between point1 and point2
  Offset centerPoint() {
    return (point1 + point2) / 2;
  }

  @override
  String toString() {
    return "Line($point1, $point2)";
  }
}
