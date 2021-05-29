import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/auto_draw_speed.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/helpers/compute_intermediate_segment_count.dart';
import 'package:inspiral/state/helpers/get_rotating_gear_state_for_version.dart';
import 'package:inspiral/state/persistors/rotating_gear_state_persistor.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:inspiral/util/calculate_rotation_count.dart';
import 'package:inspiral/util/select_closest_hole.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:pedantic/pedantic.dart';
import 'package:vector_math/vector_math.dart';

/// A utility class to hold the results of a rotation calculation
@immutable
class RotationResult {
  /// The ContactPoint of the fixed gear
  final ContactPoint fixedGearContactPoint;

  /// The ContactPoint of the rotating gear
  final ContactPoint rotatingGearContactPoint;

  /// The position of the rotating gear
  final Offset rotatingGearPosition;

  /// The rotation of the rotating gear
  final double rotatingGearRotation;

  /// The position of the pen, relative to the canvas
  final Offset penPosition;

  const RotationResult(
      {@required this.fixedGearContactPoint,
      @required this.rotatingGearContactPoint,
      @required this.rotatingGearPosition,
      @required this.rotatingGearRotation,
      @required this.penPosition});
}

class RotatingGearState extends BaseGearState {
  static RotatingGearState _instance;

  factory RotatingGearState.init() {
    return _instance = RotatingGearState._internal();
  }

  factory RotatingGearState() {
    assert(_instance != null,
        'The RotatingGearState.init() factory constructor must be called before using the RotatingGearState() constructor.');
    return _instance;
  }

  RotatingGearState._internal() : super();

  /// Initializes the position of the gear
  void initializePosition() {
    var result = _getRotationForAngle(_lastAngle);
    _updateGearState(result);
  }

  double/*!*/ _lastAngle;

  // Only exposed publicly for use in the persistor
  double/*!*/ get lastAngle => _lastAngle;

  int toothOffset = 0;

  GearHole/*!*/ _activeHole;
  GearHole/*!*/ get activeHole => _activeHole;
  set activeHole(GearHole/*!*/ value) {
    _activeHole = value;
    allStateObjects.ink.finishLine();

    notifyListeners();
  }

  /// Keeps track of whether we're in the process of drawing a complete pattern.
  /// If we are, we ignore requests to draw another complete pattern.
  bool get isDrawingCompletePattern => _isDrawingCompletePattern;
  bool _isDrawingCompletePattern = false;
  set isDrawingCompletePattern(bool value) {
    _isDrawingCompletePattern = value;
    _updateIsAutoDrawing();
  }

  /// Similar to above, but just for a single rotation.
  bool get isDrawingOneRotation => _isDrawingOneRotation;
  bool _isDrawingOneRotation = false;
  set isDrawingOneRotation(bool value) {
    _isDrawingOneRotation = value;
    _updateIsAutoDrawing();
  }

  /// Whether we're currently drawing a full _or_ a single rotation.
  bool get isAutoDrawing => _isAutoDrawing;
  bool _isAutoDrawing = false;
  void _updateIsAutoDrawing() {
    var newValue = isDrawingOneRotation || isDrawingCompletePattern;
    if (newValue != _isAutoDrawing) {
      _isAutoDrawing = newValue;
      notifyListeners();
    }
  }

  /// The position of the pen, relative to the center of the rotating gear
  Offset get relativePenPosition => _activeHole.relativeOffset;

  void fixedGearDrag(Offset rotatingGearDelta) {
    position -= rotatingGearDelta;
    allStateObjects.ink.finishLine();
  }

  @override
  void gearPointerDown(PointerDownEvent event) {
    super.gearPointerDown(event);

    if (event.device == draggingPointerId && isDragging && !isAutoDrawing) {
      var result = _getRotationForAngle(allStateObjects.dragLine.angle);
      allStateObjects.ink.addPoints([result.penPosition]);

      _snapshotIfRequested();
    }
  }

  void gearPointerMove(PointerMoveEvent event) {
    if (event.device == draggingPointerId && isDragging && !isAutoDrawing) {
      var result = _getRotationForAngle(allStateObjects.dragLine.angle);
      _updateGearState(result);
      _drawPoints(result, allStateObjects.dragLine.angle);
    }
  }

  @override
  void gearPointerUp(PointerUpEvent event) {
    if (event.device == draggingPointerId && !isAutoDrawing) {
      var result = _getRotationForAngle(allStateObjects.dragLine.angle);
      _drawPoints(result, allStateObjects.dragLine.angle, force: true);
    }

    super.gearPointerUp(event);

    // Create an undo/redo snapshot now.
    // As a side effect, this also persists the current app state to disk,
    // including the rasterizing the lines.
    allStateObjects.undoRedo.createSnapshot();

    notifyListeners();
  }

  /// Swaps the current rotating gear for a new one
  void selectNewGear(GearDefinition newGear) {
    definition = newGear;

    activeHole = selectClosetHole(
        currentHole: activeHole, availableHoles: definition.holes);

    initializePosition();
    allStateObjects.ink.finishLine();
    allStateObjects.undoRedo.createSnapshotBeforeNextDraw = true;
  }

  /// Rotates the rotating gear in place (without drawing)
  /// by the provided number of teeth in the positive direction
  void rotateInPlace({int teethToRotate}) {
    toothOffset += teethToRotate;
    initializePosition();
    allStateObjects.ink.finishLine();
    allStateObjects.undoRedo.createSnapshotBeforeNextDraw = true;
  }

  /// Draws one complete (clockwise) rotation, so that the rotating gears
  /// ends where it starts
  Future<void> drawOneRotation({bool triggerBakeAfter = true}) async {
    if (isDrawingOneRotation) {
      return;
    }

    _snapshotIfRequested();

    isDrawingOneRotation = true;

    var rotationAmount = 2 * pi * -1;

    int intervalsToDraw;
    if (allStateObjects.settings.autoDrawSpeed == AutoDrawSpeed.slow) {
      // If slow auto-draw is selected (the default), base the interval of each
      // iteraction on the number of teeth in the fixed gear. This allows
      // the drawing to be roughly the same speed for all gear pairings.
      intervalsToDraw =
          (allStateObjects.fixedGear.definition.toothCount / 2.5).round();
    } else {
      // If fast auto-draw is selected, draw as fast as possible.
      intervalsToDraw = 3;
    }

    var intervalAmount = rotationAmount / intervalsToDraw;
    for (var i = 0; i <= intervalsToDraw; i++) {
      var amountToAdd = intervalAmount * i;
      var result =
          _getRotationForAngle(allStateObjects.dragLine.angle + amountToAdd);
      _updateGearState(result);
      _drawPoints(result, allStateObjects.dragLine.angle + amountToAdd,
          force: true);

      await Future.delayed(Duration(milliseconds: 16));
    }

    allStateObjects.dragLine.angle += rotationAmount;
    isDrawingOneRotation = false;

    if (triggerBakeAfter) {
      unawaited(allStateObjects.ink.bakeImage());
      unawaited(allStateObjects.undoRedo.createSnapshot());
    }
  }

  /// Draws a complete pattern
  Future<void> drawCompletePattern() async {
    if (_isDrawingCompletePattern) {
      return;
    }

    isDrawingCompletePattern = true;
    _shouldPauseCompletePatternDrawing = false;

    var rotationsToComplete = calculateRotationCount(
        fixedGearTeeth: allStateObjects.fixedGear.definition.toothCount,
        rotatingGearTeeth: definition.toothCount,
        selectedHoleDistance: activeHole.distance,
        rotatingGearIsCircular: definition.isRound);

    for (var i = 0; i < rotationsToComplete; i++) {
      if (_shouldPauseCompletePatternDrawing) {
        break;
      }

      await drawOneRotation(triggerBakeAfter: false);
    }

    isDrawingCompletePattern = false;

    unawaited(allStateObjects.ink.bakeImage());
    unawaited(allStateObjects.undoRedo.createSnapshot());
  }

  // A flag used to indicate if the complete pattern auto-drawing
  // process should stop
  bool _shouldPauseCompletePatternDrawing = false;

  /// Stops auto-drawing if currently drawing a complete pattern.
  /// Otherwise, does nothing.
  void stopCompletePatternDrawing() {
    _shouldPauseCompletePatternDrawing = true;
  }

  /// Updates all state variables with the provide rotation calculation results
  void _updateGearState(RotationResult result) {
    rotation = result.rotatingGearRotation;
    position = result.rotatingGearPosition;

    allStateObjects.fixedGear.contactPoint = result.fixedGearContactPoint;
    contactPoint = result.rotatingGearContactPoint;
  }

  /// Calculates the effect of a rotation to the provided angle
  RotationResult _getRotationForAngle(double angle) {
    var fixedGear = allStateObjects.fixedGear;
    var fixedGearTooth = fixedGear.definition.angleToTooth(angle);

    var fixedGearContactPoint = fixedGear.definition
        .toothToContactPoint(fixedGearTooth)
        .translated(fixedGear.position);

    var rotatingGearRelativeContactPoint = definition
        .toothToContactPoint(fixedGearTooth + toothOffset, isRotating: true);

    var rotatingGearRotation = rotatingGearRelativeContactPoint.direction -
        fixedGearContactPoint.direction +
        fixedGear.rotation +
        pi;

    var rotatingGearPosition = (fixedGearContactPoint.position +
            rotatingGearRelativeContactPoint.position)
        .rotated(rotatingGearRotation - pi - fixedGear.rotation,
            fixedGearContactPoint.position)
        .rotated(fixedGear.rotation, fixedGear.position);

    var penAngle = rotatingGearRotation - activeHole.angle;
    var penPosition = Offset(cos(penAngle), sin(penAngle)) *
            activeHole.distance *
            scaleFactor +
        rotatingGearPosition;

    var rotatingGearContactPoint = rotatingGearRelativeContactPoint
        .translated(rotatingGearPosition)
        .rotated(rotatingGearRotation, rotatingGearPosition);

    return RotationResult(
        rotatingGearContactPoint: rotatingGearContactPoint,
        fixedGearContactPoint: fixedGearContactPoint,
        rotatingGearPosition: rotatingGearPosition,
        rotatingGearRotation: rotatingGearRotation,
        penPosition: penPosition);
  }

  /// Draws points to the canvas based on the provided angle.
  /// If the provided point is too close to the previous point, no point is
  /// drawn (unless the `force` parameter is provided, in which case the
  /// point is always drawn). If the provided point is within the correct range
  /// of the previous point, a single point is drawn. If the provided point is
  /// too far from the previous point, a number of intermediate points are drawn
  /// to keep the drawn line from appearing choppy.
  void _drawPoints(RotationResult result, double angle, {bool force = false}) {
    // Add a new snap point at the fixed gear's center
    allStateObjects.snapPoints.addSnapPoint(allStateObjects.fixedGear.position);

    // If `lastPoint` is `null`, this means there is no last point to compare
    // to, so we should just draw the current point immediately.
    if (allStateObjects.ink.lastPoint == null) {
      allStateObjects.ink.addPoints([result.penPosition]);
      _lastAngle = angle;
      return;
    }

    var segmentLength =
        Line(result.penPosition, allStateObjects.ink.lastPoint).length();

    // `isASmallishChange` is a flag used to indicate that the change in angle
    // since the last draw is relatively small. If the change is big, we will
    // want to break the angle into pieces and calculate intermediate results in
    // order to ensure a smooth line. This flag ensures the next few
    // optimizations below are skipped for large changes in angles that happen
    // to place points very close to each other. For an example of what this
    // is designed to prevent, see the second image here:
    // https://gitlab.com/nfriend/inspiral/-/issues/109
    var angleDeltaMagnitude = (angle - _lastAngle).abs();
    var isASmallishChange = angleDeltaMagnitude < 30 * degrees2Radians;

    // If the point is too close to the last drawn point, don't draw a new one.
    // (Unless the `force` parameter is provided,
    // in which case ignore this check.)
    if (segmentLength < minLineSegmentLength && isASmallishChange && !force) {
      return;
    }

    // If the point is in the correct range from the last point, draw it
    if (segmentLength <= maxLineSegmentLength && isASmallishChange) {
      allStateObjects.ink.addPoints([result.penPosition]);
      _lastAngle = angle;
      return;
    }

    // Otherwise, the point is too far away from the last point.
    // Calculate some intermediate points to avoid choppy lines.
    var pointsToAdd = <Offset>[];
    var segmentsToDraw = computeIntermediateSegmentCount(
        distanceFromLastPoint: segmentLength,
        angleDeltaMagnitude: angleDeltaMagnitude);
    var angleDelta = (angle - _lastAngle) / segmentsToDraw;
    for (var i = 1; i <= segmentsToDraw; i++) {
      var incrementalResult = _getRotationForAngle(_lastAngle + angleDelta * i);
      pointsToAdd.add(incrementalResult.penPosition);
    }

    allStateObjects.ink.addPoints(pointsToAdd);
    _lastAngle = angle;
  }

  /// Creates a new undo/redo snapshot if at least one state object
  /// has requested a snapshot be created at the start of the next draw action.
  void _snapshotIfRequested() {
    if (allStateObjects.undoRedo.createSnapshotBeforeNextDraw) {
      unawaited(allStateObjects.undoRedo.createSnapshot());
    }
  }

  @override
  Future<void> undo(int version) async {
    var snapshot = await getRotatingGearStateForVersion(version);

    // Don't update the isVisible property - this property should
    // not be undone/redone
    snapshot.isVisible = isVisible;

    _applyStateSnapshot(snapshot);
  }

  @override
  Future<void> redo(int version) async {
    var snapshot = await getRotatingGearStateForVersion(version);

    // Same comment as above
    snapshot.isVisible = isVisible;

    _applyStateSnapshot(snapshot);
  }

  @override
  void persist(Batch batch) {
    RotatingGearStatePersistor.persist(batch, this);
  }

  @override
  Future<void> rehydrate(Database db, BuildContext context) async {
    _applyStateSnapshot(await RotatingGearStatePersistor.rehydrate(db, this));
  }

  void _applyStateSnapshot(RotatingGearStateSnapshot snapshot) {
    _lastAngle = snapshot.angle;
    definition = snapshot.definition;
    isVisible = snapshot.isVisible;
    activeHole = snapshot.activeHole;

    initializePosition();
    notifyListeners();
  }
}
