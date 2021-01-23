import 'dart:math';
import 'package:inspiral/models/models.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';

/// Initializes all state singletons. This method must be called early in the
/// application lifecycle, and it must only be called once.
Future<void> initState(BuildContext context) async {
  Stopwatch sw = Stopwatch()..start();
  // Load all the gear definitions
  await GearDefinitions.loadGearDefinitions(context);
  sw.stop();
  print("Gear loading took ${sw.elapsedMilliseconds} ms");

  // Compute an initial canvas translation that will place the
  // center point of the canvas directly in the center of the screen
  // By default, the canvas's top-left corner is lined up with
  // the screen's top-left corner
  final Matrix4 initialCanvasTransform = Matrix4.identity();

  // Scale the canvas to the correct zoom level
  final initialZoom = 0.5;
  initialCanvasTransform.scale(initialZoom, initialZoom, 0);

  // Move the center of the canvas to the
  // top-left of the screen
  Vector3 originTranslation = -(canvasCenter.toVector3());
  initialCanvasTransform.translate(originTranslation);

  // Then, move the canvas back by half the screen dimensions
  // so that the centor of the canvas is located
  // in the center of the screen
  Vector3 centerTranslation =
      (MediaQuery.of(context).size / 2).toVector3() * (1 / initialZoom);
  initialCanvasTransform.translate(centerTranslation);

  // Initialize all the state singletons
  SettingsState.init();
  final pointers = PointersState.init();
  final canvas = CanvasState.init(initialTransform: initialCanvasTransform);
  final rotatingGear = RotatingGearState.init(
      initialAngle: pi / 2,
      initialDefinition:
          GearDefinitions.getGearDefinition(Gear.defaultRotating));
  final dragLine = DragLineState.init(initialPosition: canvasCenter);
  final fixedGear = FixedGearState.init(
      initialPosition: canvasCenter,
      initialDefinition: GearDefinitions.getGearDefinition(Gear.defaultFixed));

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