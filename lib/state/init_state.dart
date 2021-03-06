import 'dart:math';
import 'package:inspiral/models/gears/gears.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/stroke_state.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';

/// Initializes all state singletons. This method must be called early in the
/// application lifecycle, and it must only be called once.
Future<void> initState(BuildContext context,
    {@required TinyColor initialCanvasColor}) async {
  // Compute an initial canvas translation that will place the
  // center point of the canvas directly in the center of the screen
  // By default, the canvas's top-left corner is lined up with
  // the screen's top-left corner
  final Matrix4 initialCanvasTransform = Matrix4.identity();

  // Scale the canvas to the correct zoom level
  final initialZoom = 0.5;
  initialCanvasTransform.scale(initialZoom, initialZoom, 0);

  // Move the center of the canvas to the
  // top-left of the screen. Multiplied by 2, because the
  // canvas itself is offset by `canvasCenter` from its parent.
  Vector3 originTranslation = -(canvasCenter.toVector3() * 2);
  initialCanvasTransform.translate(originTranslation);

  // Then, move the canvas back by half the screen dimensions
  // so that the centor of the canvas is located
  // in the center of the screen
  Vector3 centerTranslation =
      (MediaQuery.of(context).size / 2).toVector3() * (1 / initialZoom);
  initialCanvasTransform.translate(centerTranslation);

  // The initial angle of the rotating gear, relative to the fixed gear
  double initialAngle = pi / 2;

  // Initialize all the state singletons
  ProgressState.init();
  final settings = SettingsState.init();
  final selectorDrawer = SelectorDrawerState.init();
  final purchases = PurchasesState.init(initialPurchases: [Product.free]);
  final colors = ColorState.init(
      initialBackgroundColor: initialCanvasColor,
      initialPenColor: TinyColor(Color(0x66FF0000)));
  final stroke = StrokeState.init(initialWidth: 5.0);
  final ink = InkState.init();
  final pointers = PointersState.init();
  final canvas = CanvasState.init(initialTransform: initialCanvasTransform);
  final rotatingGear = RotatingGearState.init(
      initialAngle: initialAngle,
      initialDefinition: circle24,
      initialActiveHole: circle24.holes.last);
  final dragLine = DragLineState.init(
      initialPosition: canvasCenter, initialAngle: initialAngle);
  final fixedGear = FixedGearState.init(
      initialPosition: canvasCenter, initialDefinition: oval30);

  // Link up dependencies between the singletons
  pointers.canvas = canvas;
  selectorDrawer.canvas = canvas;
  canvas.pointers = pointers;
  colors.ink = ink;
  stroke.ink = ink;
  ink
    ..colors = colors
    ..stroke = stroke;
  rotatingGear
    ..pointers = pointers
    ..dragLine = dragLine
    ..fixedGear = fixedGear
    ..ink = ink
    ..settings = settings
    ..selectorDrawer = selectorDrawer;
  dragLine
    ..canvas = canvas
    ..rotatingGear = rotatingGear;
  fixedGear
    ..pointers = pointers
    ..rotatingGear = rotatingGear
    ..ink = ink
    ..dragLine = dragLine
    ..settings = settings
    ..selectorDrawer = selectorDrawer;

  // Run any initialization logic
  rotatingGear.initializePosition();

  // TODO: how will this work offline?
  await purchases.updatePurchasedItems();
}
