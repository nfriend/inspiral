import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
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

  RotatingGearState rotatingGear;
  DragLineState dragLine;
  InkState ink;

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
    if (rotatingGear.isAutoDrawing || isLocked) {
      return;
    }

    if (event.device == draggingPointerId && isDragging) {
      final dragBounds = Rect.fromLTRB(
          -allowedDistanceFromCanvasEdge,
          -allowedDistanceFromCanvasEdge,
          canvas.canvasSize.width + allowedDistanceFromCanvasEdge,
          canvas.canvasSize.height + allowedDistanceFromCanvasEdge);

      final newPosition =
          (canvas.pixelToCanvasPosition(event.position) - dragOffset)
              .clamp(dragBounds);

      rotatingGear.fixedGearDrag(position - newPosition);
      dragLine.fixedGearDrag(position - newPosition);
      position = newPosition;
    } else if (
        // If more than one finger is touching the screen
        pointers.count > 1 &&
            // and all of the pointers are touching the fixed gear
            pointers.count == pointerIds.length &&
            // and this is the move event for the most recent finger
            event.pointer == pointerIds.last) {
      var rotationDelta =
          pointers.getTransformInfo().transformComponents.rotation;

      // `rotationDelta` is in the range [0, 2pi), Translate this
      // into the range [-pi,pi).
      if (rotationDelta > pi) {
        rotationDelta -= 2 * pi;
      }

      rotation += rotationDelta;
      rotatingGear.initializePosition();
      ink.finishLine();
    }
  }

  /// Swaps the current fixed gear for a new one
  void selectNewGear(GearDefinition newGear) {
    definition = newGear;

    if (settings.preventIncompatibleGearPairings) {
      // Update the current rotating gear selection if the newly selected
      // fixed gear is incompatible with the existing rotating gear selection.
      rotatingGear.selectNewGear(findClosestCompatibleGear(
          fixedGear: definition,
          currentlySelectedRotatingGear: rotatingGear.definition));
    }

    rotatingGear.initializePosition();
    ink.finishLine();
  }

  /// Resets the position of the gears to the center of the canvas
  void resetPosition() {
    position = canvas.canvasCenter;
    rotatingGear.initializePosition();
    dragLine.pivotPosition = position;
  }

  @override
  void persist(Batch batch) {
    FixedGearStatePersistor.persist(batch, this);
  }

  @override
  Future<void> rehydrate(Database db, BuildContext context) async {
    var result = await FixedGearStatePersistor.rehydrate(db, this);

    definition = result.definition;
    isVisible = result.isVisible;
    position = result.position;
    rotation = result.rotation;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
