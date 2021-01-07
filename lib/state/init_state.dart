import 'package:inspiral/models/models.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';

/// Initializes all state singletons. This method must be called early in the
/// application lifecycle, and it must only be called once.
void initState(BuildContext context) {
  // Compute an initial canvas translation that will place the
  // center point of the canvas directly in the center of the screen
  // By default, the canvas's top-left corner is lined up with
  // the screen's top-left corner
  final Matrix4 initialCanvasTransform = Matrix4.identity();

  // First, move the center of the canvas to the
  // top-left of the screen
  Vector3 translation = -(canvasCenter.toVector3());

  // Then, move the canvas back by half the screen dimensions
  // so that the centor of the canvas is located
  // in the centr of the screen
  translation += (MediaQuery.of(context).size / 2).toVector3();

  initialCanvasTransform.translate(translation);

  // Initialize all the state singletons
  SettingsState.init();
  final pointers = PointersState.init();
  final canvas = CanvasState.init(initialTransform: initialCanvasTransform);
  final rotatingGear = RotatingGearState.init(
      initialAngle: 0, initialDefinition: GearDefinitions.defaultRotatingGear);
  final dragLine = DragLineState.init(initialPosition: canvasCenter);
  final fixedGear = FixedGearState.init(
      initialPosition: canvasCenter,
      initialDefinition: GearDefinitions.defaultFixedGear);

  // Link up dependencies between the singletons
  canvas.pointers = pointers;
  rotatingGear
    ..pointers = pointers
    ..dragLine = dragLine
    ..fixedGear = fixedGear;
  dragLine
    ..canvas = canvas
    ..rotatingGear = rotatingGear;
  fixedGear
    ..pointers = pointers
    ..rotatingGear = rotatingGear
    ..dragLine = dragLine;

  // Run any initialization logic
  rotatingGear.initializePosition();
}
