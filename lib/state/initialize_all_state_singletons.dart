import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/state/snackbar_state.dart';
import 'package:inspiral/state/stroke_state.dart';
import 'package:inspiral/state/undo_redo_state.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';

/// This method must be called early in the application lifecycle,
/// and it must only be called once.
Future<AllStateObjects> initializeAllStateSingletons(
    BuildContext context) async {
  // Initialize all the state singletons
  final progress = ProgressState.init();
  final settings = SettingsState.init();
  final selectorDrawer = SelectorDrawerState.init();
  final purchases = PurchasesState.init();
  final colors = ColorState.init();
  final colorPicker = ColorPickerState.init();
  final stroke = StrokeState.init();
  final ink = InkState.init();
  final pointers = PointersState.init();
  final canvas = CanvasState.init();
  final rotatingGear = RotatingGearState.init();
  final dragLine = DragLineState.init();
  final fixedGear = FixedGearState.init();
  final snackbarState = SnackbarState.init();
  final snapPoints = SnapPointState.init();
  final undoRedo = UndoRedoState.init();

  // TODO: Remove all these, and make state objects
  // reference each other using `allStateObjects` instead.
  // Link up dependencies between the singletons
  settings
    ..fixedGear = fixedGear
    ..rotatingGear = rotatingGear;
  pointers.canvas = canvas;
  canvas
    ..pointers = pointers
    ..ink = ink
    ..fixedGear = fixedGear
    ..snapPoints = snapPoints;
  colors.ink = ink;
  stroke.ink = ink;
  purchases.settings = settings;
  selectorDrawer
    ..canvas = canvas
    ..colors = colors;
  ink
    ..colors = colors
    ..stroke = stroke
    ..canvas = canvas
    ..undoRedo = undoRedo;
  rotatingGear
    ..canvas = canvas
    ..pointers = pointers
    ..dragLine = dragLine
    ..fixedGear = fixedGear
    ..ink = ink
    ..settings = settings
    ..selectorDrawer = selectorDrawer
    ..snapPoints = snapPoints;
  dragLine
    ..canvas = canvas
    ..rotatingGear = rotatingGear
    ..fixedGear = fixedGear;
  fixedGear
    ..canvas = canvas
    ..pointers = pointers
    ..rotatingGear = rotatingGear
    ..ink = ink
    ..dragLine = dragLine
    ..settings = settings
    ..selectorDrawer = selectorDrawer
    ..snapPoints = snapPoints;

  var allStateObjects = AllStateObjects(
      canvas: canvas,
      progress: progress,
      settings: settings,
      selectorDrawer: selectorDrawer,
      purchases: purchases,
      colors: colors,
      stroke: stroke,
      ink: ink,
      pointers: pointers,
      fixedGear: fixedGear,
      rotatingGear: rotatingGear,
      dragLine: dragLine,
      colorPicker: colorPicker,
      snackbarState: snackbarState,
      snapPoints: snapPoints,
      undoRedo: undoRedo);

  // Unfortunately, these iterations cannot be combined, since each calls
  // methods that rely on references initialized in the previous iteration.
  // Fortunately, the list will always be quite small.
  for (var stateObject in allStateObjects.list) {
    stateObject.allStateObjects = allStateObjects;
  }

  for (var stateObject in allStateObjects.list) {
    stateObject.startListening();
  }

  var db = await getDatabase();
  for (var stateObject in allStateObjects.list) {
    await stateObject.rehydrate(db, context);
  }

  await Purchases.setDebugLogsEnabled(settings.debug);
  await Purchases.setup('QKEkbCDUrOGPRFLYtdbOQUCRNxEXbCgz');

  return allStateObjects;
}
