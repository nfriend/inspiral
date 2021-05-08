import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:inspiral/state/initializable_for_listening.dart';
import 'package:inspiral/state/persistors/persistable.dart';
import 'package:inspiral/state/snackbar_state.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/state/undoers/undoable.dart';

class AllStateObjects {
  final CanvasState canvas;
  final ProgressState progress;
  final SettingsState settings;
  final SelectorDrawerState selectorDrawer;
  final PurchasesState purchases;
  final ColorState colors;
  final StrokeState stroke;
  final InkState ink;
  final PointersState pointers;
  final FixedGearState fixedGear;
  final RotatingGearState rotatingGear;
  final DragLineState dragLine;
  final ColorPickerState colorPicker;
  final SnackbarState snackbarState;
  final SnapPointState snapPoints;
  final UndoRedoState undoRedo;

  UnmodifiableListView<InspiralStateObject> list;

  AllStateObjects(
      {@required this.canvas,
      @required this.progress,
      @required this.settings,
      @required this.selectorDrawer,
      @required this.purchases,
      @required this.colors,
      @required this.stroke,
      @required this.ink,
      @required this.pointers,
      @required this.fixedGear,
      @required this.rotatingGear,
      @required this.dragLine,
      @required this.colorPicker,
      @required this.snackbarState,
      @required this.snapPoints,
      @required this.undoRedo}) {
    // Order matters. The order in which these state object are specified
    // here is the order in which they will be hydrated (which matters
    // for some state objects).
    list = UnmodifiableListView([
      canvas,
      progress,
      settings,
      selectorDrawer,
      purchases,
      colors,
      stroke,
      ink,
      pointers,
      fixedGear,
      rotatingGear,
      dragLine,
      colorPicker,
      snackbarState,
      snapPoints,
      undoRedo
    ]);
  }
}

abstract class InspiralStateObject extends ChangeNotifier
    with Persistable, Undoable, InitializableForListening {
  AllStateObjects allStateObjects;
}
