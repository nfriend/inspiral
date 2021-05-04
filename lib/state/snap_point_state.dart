import 'dart:collection';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/persistors/persistable.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/extensions/extensions.dart';

class _SnapPointAndDistance {
  final Offset snapPoint;
  final double distance;

  _SnapPointAndDistance({this.snapPoint, this.distance});
}

class SnapPointState extends ChangeNotifier with Persistable {
  static SnapPointState _instance;

  factory SnapPointState.init() {
    return _instance = SnapPointState._internal();
  }

  factory SnapPointState() {
    assert(_instance != null,
        'The SnapPointState.init() factory constructor must be called before using the SnapPointState() constructor.');
    return _instance;
  }

  SnapPointState._internal() : super() {
    _snapPoints = HashSet();
    _unmodifiableSnapPoints = UnmodifiableSetView(_snapPoints);
  }

  UnmodifiableSetView<Offset> _unmodifiableSnapPoints;
  Set<Offset> _snapPoints;

  /// The set of all fixed gear snap points
  Set<Offset> get snapPoints => _unmodifiableSnapPoints;

  /// Adds a snap point to the set of snap points, and set the
  /// point as the new active point.
  /// If the point already exists, this does nothing.
  void addSnapPoint(Offset point) {
    var wasNewPoint = _snapPoints.add(point);

    if (wasNewPoint) {
      // Also make this point the new active snap point, since we know the
      // fixed gear is currently at this position.
      activeSnapPoint = point;

      notifyListeners();
    }
  }

  /// Whether or not the snap points are visible
  bool get areVisible => _areVisible;
  bool _areVisible = true;
  set areVisible(bool value) {
    _areVisible = value;
    notifyListeners();
  }

  /// The snap point that the fixed gear is currently snapped to.
  /// If no snap point is active, this is `null`.
  Offset get activeSnapPoint => _activeSnapPoint;
  Offset _activeSnapPoint;
  set activeSnapPoint(Offset value) {
    if (_activeSnapPoint != value) {
      _activeSnapPoint = value;
      notifyListeners();
    }
  }

  /// Snaps the provided position to the nearest snap point.
  /// If the position is not close enough to snap to any snap points,
  /// the original Offset is returned.
  Offset snapPositionToNearestPoint(Offset position) {
    _SnapPointAndDistance closestSnapPoint;
    for (var point in _snapPoints) {
      var distance = point.distanceTo(position);

      if (closestSnapPoint == null || distance < closestSnapPoint.distance) {
        closestSnapPoint =
            _SnapPointAndDistance(snapPoint: point, distance: distance);
      }
    }

    if (closestSnapPoint != null &&
        closestSnapPoint.distance <= snapPointThreshold) {
      activeSnapPoint = closestSnapPoint.snapPoint;
      return closestSnapPoint.snapPoint;
    } else {
      activeSnapPoint = null;
      return position;
    }
  }
}