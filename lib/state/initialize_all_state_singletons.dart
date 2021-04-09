import 'dart:math';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/state/persistors/persistable.dart';
import 'package:inspiral/state/stroke_state.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';

/// This method must be called early in the application lifecycle,
/// and it must only be called once.
Future<Iterable<Persistable>> initializeAllStateSingletons(
    BuildContext context) async {
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
  final canvas = CanvasState.init();
  final rotatingGear = RotatingGearState.init();
  final dragLine = DragLineState.init(
      initialPosition: canvasCenter, initialAngle: initialAngle);
  final fixedGear = FixedGearState.init();

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

  // Order matters. The order in which these state object are specified
  // here is the order in which they will be hydrated (which matters
  // for some state objects).
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
    fixedGear,
    rotatingGear,
    dragLine,
    colorPicker
  ];

  Database db = await getDatabase();
  for (Persistable stateObject in allStateObjects) {
    await stateObject.rehydrate(db, context);
  }
  db.close();

  await Purchases.setDebugLogsEnabled(settings.debug);
  await Purchases.setup("QKEkbCDUrOGPRFLYtdbOQUCRNxEXbCgz");

  return allStateObjects;
}
