import 'dart:collection';
import 'package:inspiral/constants.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:inspiral/state/persistors/snap_point_state_persistor.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/state/undoers/snap_point_state_undoer.dart';
import 'package:sqflite/sqflite.dart';

class _SnapPointAndDistance {
  final Offset snapPoint;
  final double distance;

  _SnapPointAndDistance({required this.snapPoint, required this.distance});
}

class SnapPointState extends InspiralStateObject {
  static SnapPointState? _instance;

  factory SnapPointState.init() {
    return _instance = SnapPointState._internal();
  }

  factory SnapPointState() {
    assert(_instance != null,
        'The SnapPointState.init() factory constructor must be called before using the SnapPointState() constructor.');
    return _instance!;
  }

  SnapPointState._internal() : super() {
    _snapPoints = HashSet();
    _unmodifiableSnapPoints = UnmodifiableSetView(_snapPoints);
  }

  late UnmodifiableSetView<Offset> _unmodifiableSnapPoints;
  late Set<Offset> _snapPoints;

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

  /// Whether or not the snap points are active
  bool get areActive => _areActive;
  bool _areActive = true;
  set areActive(bool value) {
    _areActive = value;
    notifyListeners();
  }

  /// The snap point that the fixed gear is currently snapped to.
  /// If no snap point is active, this is `null`.
  Offset? get activeSnapPoint => _activeSnapPoint;
  Offset? _activeSnapPoint;
  set activeSnapPoint(Offset? value) {
    if (_activeSnapPoint != value) {
      _activeSnapPoint = value;
      notifyListeners();
    }
  }

  /// Snaps the provided position to the nearest snap point.
  /// If the position is not close enough to snap to any snap points,
  /// the original Offset is returned.
  Offset snapPositionToNearestPoint(Offset position) {
    if (!areActive) {
      activeSnapPoint = null;
      return position;
    }

    _SnapPointAndDistance? closestSnapPoint;
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

  /// Erases all snap points
  void eraseAllSnapPoints() {
    _snapPoints.removeWhere((element) => true);
    notifyListeners();
  }

  @override
  Future<void> undo(int version) async {
    var result = await SnapPointStateUndoer.undo(version, this);

    _updateState(
        snapPoints: result.snapPoints,
        activeSnapPoint: result.activeSnapPoint,

        // `areActive` is not affected by undo
        areActive: areActive);
  }

  @override
  Future<void> redo(int version) async {
    var result = await SnapPointStateUndoer.redo(version, this);

    _updateState(
        snapPoints: result.snapPoints,
        activeSnapPoint: result.activeSnapPoint,

        // `areActive` is not affected by redo
        areActive: areActive);
  }

  @override
  Future<void> snapshot(int version, Batch batch) async {
    await SnapPointStateUndoer.snapshot(version, batch, this);
  }

  @override
  Future<void> cleanUpOldRedoSnapshots(int version, Batch batch) async {
    await SnapPointStateUndoer.cleanUpOldRedoSnapshots(version, batch);
  }

  @override
  void persist(Batch batch) {
    SnapPointStatePersistor.persist(batch, this);
  }

  @override
  Future<void> rehydrate(Database db, BuildContext context) async {
    var result = await SnapPointStatePersistor.rehydrate(db);

    _updateState(
        snapPoints: result.snapPoints,
        activeSnapPoint: result.activeSnapPoint,
        areActive: result.areActive);
  }

  void _updateState(
      {required Set<Offset> snapPoints,
      required Offset? activeSnapPoint,
      required bool areActive}) {
    _snapPoints.removeWhere((element) => true);
    _snapPoints.addAll(snapPoints);
    _areActive = areActive;
    _activeSnapPoint = activeSnapPoint;

    notifyListeners();
  }
}
