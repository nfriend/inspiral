import 'dart:math';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/models/gears/gears.dart';
import 'package:inspiral/state/persistors/persistable.dart';
import 'package:inspiral/state/stroke_state.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';

/// This method must be called early in the application lifecycle,
/// and it must only be called once.
Future<Iterable<Persistable>> initializeAllStateSingletons(
    BuildContext context) async {
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
  final progress = ProgressState.init();
  final settings = SettingsState.init();
  final selectorDrawer = SelectorDrawerState.init();
  final purchases = PurchasesState.init();

  final colors = ColorState.init();
  final colorPicker = ColorPickerState.init();
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
  canvas.pointers = pointers;
  colors.ink = ink;
  stroke.ink = ink;
  purchases.settings = settings;
  selectorDrawer
    ..canvas = canvas
    ..colors = colors;
  ink
    ..colors = colors
    ..stroke = stroke;
  rotatingGear
    ..canvas = canvas
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
    ..canvas = canvas
    ..pointers = pointers
    ..rotatingGear = rotatingGear
    ..ink = ink
    ..dragLine = dragLine
    ..settings = settings
    ..selectorDrawer = selectorDrawer;

  Iterable<Persistable> allStateObjects = [
    progress,
    settings,
    selectorDrawer,
    purchases,
    colors,
    stroke,
    ink,
    pointers,
    canvas,
    rotatingGear,
    fixedGear,
    dragLine,
    colorPicker
  ];

  // Run any initialization logic
  rotatingGear.initializePosition();
  Database db = await getDatabase();
  await Future.wait(allStateObjects.map((state) => state.rehydrate(db)));
  db.close();

  await Purchases.setDebugLogsEnabled(settings.debug);
  await Purchases.setup("QKEkbCDUrOGPRFLYtdbOQUCRNxEXbCgz");

  return allStateObjects;
}
