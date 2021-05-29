import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/models/stroke_style.dart';
import 'package:quiver/core.dart';

/// Represents a line if ink on the canvas
class InkLine {
  final List<List<Offset>> _points;
  UnmodifiableListView<List<Offset>>/*!*/ _unmodifiablePoints;
  final List<Path> _paths;
  UnmodifiableListView<Path>/*!*/ _unmodifiablePaths;
  int/*!*/ _pointCount;
  int _mark = 0;

  InkLine(
      {@required Color color,
      @required double/*!*/ strokeWidth,
      @required StrokeStyle/*!*/ strokeStyle})
      : this._internal(
            color: color,
            strokeWidth: strokeWidth,
            strokeStyle: strokeStyle,
            initialPoints: [],
            initialPaths: [],
            initialPointCount: 0);

  /// An internal constructor, used to create an instance with points and path
  /// already set.
  InkLine._internal(
      {@required this.color,
      @required this.strokeWidth,
      @required this.strokeStyle,
      @required List<List<Offset>> initialPoints,
      @required List<Path> initialPaths,
      @required int/*!*/ initialPointCount})
      : _points = initialPoints,
        _paths = initialPaths {
    _unmodifiablePoints = UnmodifiableListView(_points);
    _unmodifiablePaths = UnmodifiableListView(_paths);
    _pointCount = initialPointCount;
  }

  /// Returns a deep copy of this InkLine
  factory InkLine.from(InkLine source) {
    return InkLine._internal(
        color: source.color,
        strokeWidth: source.strokeWidth,
        strokeStyle: source.strokeStyle,
        initialPoints:
            source.points.map((p) => List<Offset>.from(p).toList()).toList(),
        initialPaths: source.paths.map((p) => Path.from(p)).toList(),
        initialPointCount: source.pointCount);
  }

  /// The color of this line
  final Color color;

  /// The stroke width of this line
  final double/*!*/ strokeWidth;

  /// The stroke style of this line
  final StrokeStyle/*!*/ strokeStyle;

  /// The list of points that define this line. This list is kept in sync
  /// with the `paths` property below.
  /// Each sublist represents the points included in its associated `Path`
  List<List<Offset>>/*!*/ get points => _unmodifiablePoints;

  /// The total number of points incuded in this line
  int/*!*/ get pointCount => _pointCount;

  /// This line, represented as a series of `Path`s
  List<Path>/*!*/ get paths => _unmodifiablePaths;

  /// Add points to this line's list of points and its path
  void addPoints(List<Offset> pointsToAdd) {
    for (var point in pointsToAdd) {
      // If we haven't yet start a line segment, start one now.
      // Side note: because of this, it's always safe to call `.last` below.
      if (_points.isEmpty) {
        startNewPath();
      }

      // In order to simulate the "overlapping" effect of a real marker
      // (drawing over an existing line makes the intersection less
      // transparent), every time we cross the horizontal inflection point
      // (moving from positive to negative, or vice versa), we begin a new path.
      // Idea from: https://stackoverflow.com/a/47141411/1063392
      if (_points.last.length > 1) {
        var penultimatePoint = _points.last[_points.last.length - 2];
        var lastPoint = _points.last[_points.last.length - 1];

        // The last two points were trending negative, but the new point
        // takes us in a positive direction
        var isTransitioningFromNegativeToPositiveHorizontalMotion =
            penultimatePoint.dx - lastPoint.dx >= 0 &&
                lastPoint.dx - point.dx < 0;

        // The reverse of the above
        var isTransitioningFromPositiveToNegativeHorizontalMotion =
            penultimatePoint.dx - lastPoint.dx <= 0 &&
                lastPoint.dx - point.dx > 0;

        // In either case, begin a new line.
        if (isTransitioningFromNegativeToPositiveHorizontalMotion ||
            isTransitioningFromPositiveToNegativeHorizontalMotion) {
          startNewPath();
        }
      }

      var previousPointList =
          _points.length > 1 ? _points[_points.length - 2] : <Offset>[];
      var currentPointList = _points.last;
      var currentPath = _paths.last;

      if (currentPointList.isEmpty) {
        // We haven't added any points to the current line segment

        if (previousPointList.isNotEmpty) {
          // There is a previous line segment, and it has at least one point.
          // In this case, we want to make sure the current line connects
          // the previous one. We do this by moving the start of the new line
          // to the end of the previous line.
          // This isn't _quite_ perfect - in lines with really thick strokes,
          // this causes a minor gap between the connections. To fix this,
          // we _could_ try and add an intermediate point between the last
          // and current points in order to force the "angle" of the stroke
          // to perfectly align with the previous line. But this is such
          // a small issue, it doesn't seem worth the extra complexity.

          var lastPointOfPreviousLine = previousPointList.last;

          currentPointList.add(lastPointOfPreviousLine);
          currentPath.moveTo(
              lastPointOfPreviousLine.dx, lastPointOfPreviousLine.dy);

          currentPointList.add(point);
          currentPath.lineTo(point.dx, point.dy);
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

  /// Causes the current Path to be ended; and new points added
  /// will be added to a new `Path` instance.
  void startNewPath() {
    _paths.add(Path());
    _points.add([]);
  }

  /// Causes the current path to be ended; any new drawing will happen in a
  /// new `Path`. This "location" in the line is marked, and is used
  /// to determine which parts of the path to discard
  /// during `removePointsUpToMarkedSplit`.
  void markAndSplitCurrentPath() {
    _mark = _paths.length;
    startNewPath();
  }

  /// Discards all points before the "mark" created
  /// with `markAndSplitCurrentPath`
  void removePointsUpToMarkedSplit() {
    _points.removeRange(0, _mark);
    _paths.removeRange(0, _mark);
    _pointCount = _points.fold(0, (sum, points) => sum + points.length);
  }

  @override
  bool operator ==(Object other) =>
      other is InkLine &&
      other.color == color &&
      other.strokeWidth == strokeWidth &&
      listEquals(other.paths, paths);

  @override
  int get hashCode =>
      hash3(color.hashCode, strokeWidth.hashCode, paths.hashCode);
}
