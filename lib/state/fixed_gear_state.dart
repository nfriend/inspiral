import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/helpers/get_fixed_gear_state_for_version.dart';
import 'package:inspiral/state/persistors/fixed_gear_state_persistor.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:inspiral/util/find_closest_compatible_gear.dart';
import 'package:sqflite/sqlite_api.dart';

// An arbitrary number that allows even the biggest gear
// combination to always be draggable.
const double allowedDistanceFromCanvasEdge = 2200.0;

class FixedGearState extends BaseGearState with WidgetsBindingObserver {
  static FixedGearState _instance;

  factory FixedGearState.init() {
    return _instance = FixedGearState._internal();
  }

  factory FixedGearState() {
    assert(_instance != null,
        'The FixedGearState.init() factory constructor must be called before using the FixedGearState() constructor.');
    return _instance;
  }

  FixedGearState._internal() : super() {
    WidgetsBinding.instance.addObserver(this);
  }

  /// When the app is paused and then resumed, reset the state of all our
  /// pointer tracking, since they are no longer up-to-date
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      pointerIds.removeWhere((element) => true);
    }
  }

  /// The list of pointer IDs currently touching this gear
  List<int> pointerIds = [];

  /// Whether or not this gear is locked into place (i.e. it can't
  /// be moved or rotated)
  bool get isLocked => _isLocked;
  bool _isLocked = false;
  set isLocked(bool value) {
    _isLocked = value;
    notifyListeners();
  }

  @override
  void gearPointerDown(PointerDownEvent event) {
    super.gearPointerDown(event);

    pointerIds.add(event.pointer);

    // If we begin a multi-touch gesture on this gear (which will rotate the
    // gears in place), we want to cancel any future dragging to prevent
    // edge casese when transitioning back to dragging and to prevent
    // accidental drags when lifting fingers. Setting `draggingPointerId` to -1
    // effectively cancels fixed gear dragging until all the pointers all
    // lifted from the screen.
    if (pointerIds.length > 1) {
      draggingPointerId = -1;
    }
  }

  @override
  void gearPointerUp(PointerUpEvent event) {
    super.gearPointerUp(event);

    pointerIds.remove(event.pointer);
  }

  void gearPointerMove(PointerMoveEvent event) {
    // Disable any gear interactions if we're currently auto-drawing
    // or if the fixed gear is locked
    if (allStateObjects.rotatingGear.isAutoDrawing || isLocked) {
      return;
    }

    if (event.device == draggingPointerId && isDragging) {
      allStateObjects.undoRedo.createSnapshotBeforeNextDraw = true;

      final dragBounds = Rect.fromLTRB(
          -allowedDistanceFromCanvasEdge,
          -allowedDistanceFromCanvasEdge,
          allStateObjects.canvas.canvasSize.width +
              allowedDistanceFromCanvasEdge,
          allStateObjects.canvas.canvasSize.height +
              allowedDistanceFromCanvasEdge);

      final unSnappedNewPosition =
          (allStateObjects.canvas.pixelToCanvasPosition(event.position) -
                  dragOffset)
              .clamp(dragBounds);

      final newPosition = allStateObjects.snapPoints
          .snapPositionToNearestPoint(unSnappedNewPosition);

      allStateObjects.rotatingGear.fixedGearDrag(position - newPosition);
      allStateObjects.dragLine.fixedGearDrag(position - newPosition);
      position = newPosition;
    } else if (
        // If more than one finger is touching the screen
        allStateObjects.pointers.count > 1 &&
            // and all of the pointers are touching the fixed gear
            allStateObjects.pointers.count == pointerIds.length &&
            // and this is the move event for the most recent finger
            event.pointer == pointerIds.last) {
      allStateObjects.undoRedo.createSnapshotBeforeNextDraw = true;

      var rotationDelta = allStateObjects.pointers
          .getTransformInfo()
          .transformComponents
          .rotation;

      // `rotationDelta` is in the range [0, 2pi), Translate this
      // into the range [-pi,pi).
      if (rotationDelta > pi) {
        rotationDelta -= 2 * pi;
      }

      rotation += rotationDelta;
      allStateObjects.rotatingGear.initializePosition();
      allStateObjects.ink.finishLine();
    }
  }

  /// Swaps the current fixed gear for a new one
  void selectNewGear(GearDefinition newGear) {
    definition = newGear;

    if (allStateObjects.settings.preventIncompatibleGearPairings) {
      // Update the current rotating gear selection if the newly selected
      // fixed gear is incompatible with the existing rotating gear selection.
      allStateObjects.rotatingGear.selectNewGear(findClosestCompatibleGear(
          fixedGear: definition,
          currentlySelectedRotatingGear:
              allStateObjects.rotatingGear.definition));
    }

    allStateObjects.rotatingGear.initializePosition();
    allStateObjects.ink.finishLine();
    allStateObjects.undoRedo.createSnapshotBeforeNextDraw = true;
  }

  /// Resets the position of the gears to the center of the canvas
  void resetPosition() {
    position = allStateObjects.canvas.canvasCenter;
    allStateObjects.rotatingGear.initializePosition();
    allStateObjects.dragLine.pivotPosition = position;
  }

  @override
  Future<void> undo(int version) async {
    _applyStateSnapshot(
        await getFixedGearStateForVersion(version, allStateObjects));
  }

  @override
  Future<void> redo(int version) async {
    _applyStateSnapshot(
        await getFixedGearStateForVersion(version, allStateObjects));
  }

  @override
  void persist(Batch batch) {
    FixedGearStatePersistor.persist(batch, this);
  }

  @override
  Future<void> rehydrate(Database db, BuildContext context) async {
    _applyStateSnapshot(await FixedGearStatePersistor.rehydrate(db, this));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _applyStateSnapshot(FixedGearStateSnapshot snapshot) {
    definition = snapshot.definition;
    isVisible = snapshot.isVisible;
    position = snapshot.position;
    rotation = snapshot.rotation;
    isLocked = snapshot.isLocked;

    notifyListeners();
  }
}
