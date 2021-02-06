import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:quiver/core.dart';

/// Represents a line if ink on the canvas
class InkLine {
  /// The color of this line
  Color color = defaultLineColor;

  /// The stroke width of this line
  double strokeWidth = defaultStokeWidth;

  /// The list of points that define this line
  List<Offset> points = [];

  /// Returns a deep clone of this line
  InkLine clone() {
    return InkLine()
      ..color = color
      ..strokeWidth = strokeWidth
      ..points = List<Offset>.from(points);
  }

  bool operator ==(Object other) =>
      other is InkLine &&
      other.color == color &&
      other.strokeWidth == strokeWidth &&
      listEquals(other.points, points);

  int get hashCode =>
      hash3(color.hashCode, strokeWidth.hashCode, points.hashCode);
}
