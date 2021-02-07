import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:quiver/core.dart';

/// Represents a line if ink on the canvas
class InkLine {
  final List<List<Offset>> _points;
  UnmodifiableListView<List<Offset>> _unmodifiablePoints;
  final List<Path> _paths;
  UnmodifiableListView<Path> _unmodifiablePaths;
  int _pointCount;

  /// The color of this line
  Color color = defaultLineColor;

  /// The stroke width of this line
  double strokeWidth = defaultStokeWidth;

  /// The list of points that define this line. This list is kept in sync
  /// with the `paths` property below.
  /// Each sublist represents the points included in its associated `Path`
  List<List<Offset>> get points => _unmodifiablePoints;

  /// The total number of points incuded in this line
  int get pointCount => _pointCount;

  /// This line, represented as a series of `Path`s
  List<Path> get paths => _unmodifiablePaths;

  /// Add points to this line's list of points and its path
  void addPoints(List<Offset> pointsToAdd) {
    for (Offset point in pointsToAdd) {
      // If we haven't yet start a line segment, start one now.
      // Side note: because of this, it's always safe to call `.last` below.
      if (_points.isEmpty) {
        _paths.add(Path());
        _points.add([]);
      }

      // In order to simulate the "overlapping" effect of a real marker
      // (drawing over an existing line makes the intersection less
      // transparent), every time we cross the horizontal inflection point
      // (moving from positive to negative, or vice versa), we begin a new path.
      // Idea from: https://stackoverflow.com/a/47141411/1063392
      if (_points.last.length > 1) {
        Offset penultimatePoint = _points.last[_points.last.length - 2];
        Offset lastPoint = _points.last[_points.last.length - 1];

        // The last two points were trending negative, but the new point
        // takes us in a positive direction
        bool isTransitioningFromNegativeToPositiveHorizontalMotion =
            penultimatePoint.dx - lastPoint.dx >= 0 &&
                lastPoint.dx - point.dx < 0;

        // The reverse of the above
        bool isTransitioningFromPositiveToNegativeHorizontalMotion =
            penultimatePoint.dx - lastPoint.dx <= 0 &&
                lastPoint.dx - point.dx > 0;

        // In either case, begin a new line.
        if (isTransitioningFromNegativeToPositiveHorizontalMotion ||
            isTransitioningFromPositiveToNegativeHorizontalMotion) {
          _paths.add(Path());
          _points.add([]);
        }
      }

      List<Offset> previousPointList =
          _points.length > 1 ? _points[_points.length - 2] : [];
      List<Offset> currentPointList = _points.last;
      Path previousPath = _paths.length > 1 ? _paths[_paths.length - 2] : null;
      Path currentPath = _paths.last;

      if (currentPointList.isEmpty) {
        // We haven't added any points to the current line segment

        if (previousPointList.isNotEmpty) {
          // There is a previous line segment, and it has at least one point.
          // In this case, we want to make sure the current line connects
          // the previous one. We do this by adding an intermediate point
          // between the last point of the previous line and the current point,
          // which ensures there's no disconnect between the two line segments.
          Offset lastPointOfPreviousLine = previousPointList.last;
          Offset pointBetweenLastAndCurrent =
              (lastPointOfPreviousLine + point) / 2;

          previousPointList.add(pointBetweenLastAndCurrent);
          previousPath.lineTo(
              pointBetweenLastAndCurrent.dx, pointBetweenLastAndCurrent.dy);

          currentPointList.add(pointBetweenLastAndCurrent);
          currentPath.moveTo(
              pointBetweenLastAndCurrent.dx, pointBetweenLastAndCurrent.dy);

          currentPointList.add(point);
          currentPath.lineTo(point.dx, point.dy);

          // Add one extra point to keep track of the intermediate point
          // we created and added above.
          _pointCount += 1;
        } else {
          // The current line is empty, and there is no previous line to connect
          // to, so just move to the position in preparation for drawing the
          // next point.
          currentPointList.add(point);
          currentPath.moveTo(point.dx, point.dy);
        }
      } else {
        // We're adding to an existing line that already has at least one point.
        // Draw a line from the last point to the current point.
        currentPointList.add(point);
        currentPath.lineTo(point.dx, point.dy);
      }
    }

    _pointCount += pointsToAdd.length;
  }

  /// Removes points from this line, from `startIndex` (inclusive) to
  /// `endIndex` (exclusive).
  void removePointRange(int startIndex, int endIndex) {
    this._points.removeRange(startIndex, endIndex);
  }

  InkLine()
      : this._internal(
            initialPoints: [], initialPaths: [], initialPointCount: 0);

  /// An internal constructor, used to create an instance with points and path
  /// already set.
  InkLine._internal(
      {@required List<List<Offset>> initialPoints,
      @required List<Path> initialPaths,
      @required int initialPointCount})
      : _points = initialPoints,
        _paths = initialPaths {
    _unmodifiablePoints = UnmodifiableListView(_points);
    _unmodifiablePaths = UnmodifiableListView(_paths);
    _pointCount = initialPointCount;
  }

  /// Returns a deep copy of this InkLine
  factory InkLine.from(InkLine source) {
    return InkLine._internal(
        initialPoints:
            source.points.map((p) => List<Offset>.from(p).toList()).toList(),
        initialPaths: source.paths.map((p) => Path.from(p)).toList(),
        initialPointCount: source.pointCount)
      ..color = source.color
      ..strokeWidth = source.strokeWidth;
  }

  bool operator ==(Object other) =>
      other is InkLine &&
      other.color == color &&
      other.strokeWidth == strokeWidth &&
      listEquals(other.paths, paths);

  int get hashCode =>
      hash3(color.hashCode, strokeWidth.hashCode, paths.hashCode);
}
