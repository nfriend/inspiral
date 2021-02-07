import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:quiver/core.dart';

/// Represents a line if ink on the canvas
class InkLine {
  final List<Offset> _points;
  UnmodifiableListView<Offset> _unmodifiablePoints;
  final Path _path;

  /// The color of this line
  Color color = defaultLineColor;

  /// The stroke width of this line
  double strokeWidth = defaultStokeWidth;

  /// The list of paths that define this line
  List<Offset> get points => _unmodifiablePoints;

  /// This line, represented as a Path
  Path get path => _path;

  /// Add points to this line's list of points and its path
  void addPoints(List<Offset> pointsToAdd) {
    for (Offset point in pointsToAdd) {
      _points.isEmpty
          ? path.moveTo(point.dx, point.dy)
          : path.lineTo(point.dx, point.dy);
      _points.add(point);
    }
  }

  /// Removes points from this line, from `startIndex` (inclusive) to
  /// `endIndex` (exclusive).
  void removePointRange(int startIndex, int endIndex) {
    this._points.removeRange(startIndex, endIndex);
  }

  InkLine() : this._internal(initialPoints: [], initialPath: Path());

  /// An internal constructor, used to create an instance with points and path
  /// already set.
  InkLine._internal({List<Offset> initialPoints, Path initialPath})
      : _points = initialPoints,
        _path = initialPath {
    _unmodifiablePoints = UnmodifiableListView(_points);
  }

  /// Returns a deep copy of this InkLine
  factory InkLine.from(InkLine source) {
    return InkLine._internal(
        initialPoints: List<Offset>.from(source.points),
        initialPath: Path.from(source.path))
      ..color = source.color
      ..strokeWidth = source.strokeWidth;
  }

  bool operator ==(Object other) =>
      other is InkLine &&
      other.color == color &&
      other.strokeWidth == strokeWidth &&
      listEquals(other.points, points);

  int get hashCode =>
      hash3(color.hashCode, strokeWidth.hashCode, points.hashCode);
}
