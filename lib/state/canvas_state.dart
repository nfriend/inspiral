import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/persistors/canvas_state_persistor.dart';
import 'package:inspiral/state/persistors/persistable.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:inspiral/state/state.dart';

class CanvasState extends ChangeNotifier with Persistable {
  static CanvasState _instance;

  factory CanvasState.init() {
    return _instance = CanvasState._internal();
  }

  factory CanvasState() {
    assert(_instance != null,
        'The CanvasState.init() factory constructor must be called before using the CanvasState() constructor.');
    return _instance;
  }

  CanvasState._internal() : super();

  PointersState pointers;

  Matrix4 _transform;

  /// The current transformation of the canvas
  Matrix4 get transform => _transform;
  set transform(Matrix4 value) {
    _transform = value;
    notifyListeners();
  }

  /// Whether or not the canvas is being panned/rotated/zoomed
  bool get isTransforming => _isTransforming;
  bool _isTransforming = false;
  set isTransforming(bool value) {
    _isTransforming = value;
    notifyListeners();
  }

  /// Whether or not the user is currently selecting a hole in the rotating
  /// gear. When this is true, the camera zooms/pans/rotates to exactly fit the
  /// rotating gear in the available space.
  bool get isSelectingHole => _isSelectingHole;
  bool _isSelectingHole = false;
  set isSelectingHole(bool value) {
    _isSelectingHole = value;
    notifyListeners();
  }

  /// Translates a coordinate in logical pixels to coordinates on the drawing
  /// canvas. If for some reason this isn't possible (i.e., if the inverse
  /// of the translate matrix can't be computed), this method returns
  /// Offset.zero.
  ///
  /// This process was stolen from this flutter PR:
  /// https://github.com/flutter/flutter/pull/32192/files#r287158219
  ///
  /// @param pixelPosition The pixel coordinates to translate into canvas
  /// coordinates
  Offset pixelToCanvasPosition(Offset pixelPosition) {
    Matrix4 unprojection =
        Matrix4.tryInvert(PointerEvent.removePerspectiveTransform(transform));

    if (unprojection == null) {
      return Offset.zero;
    }

    // Subtracting `canvasCenter` accounts for the fact that the canvas
    // is offset in its parent by `canvasCenter`. This is to allow pointer
    // events to work even when the gears are outside of the bounds of the
    // canvas.
    return PointerEvent.transformPosition(unprojection, pixelPosition) -
        canvasCenter;
  }

  /// Notifies this state object when either the app background
  /// or the canvas is pressed
  void appBackgroundOrCanvasDown(PointerDownEvent event) {
    isTransforming = true;
  }

  /// Translates the view when either the app background or the
  /// empty canvas is moved.
  void appBackgroundOrCanvasMove(PointerMoveEvent event) {
    if (pointers.count > 0) {
      transform = pointers.getTransform() * transform;
    }
  }

  /// Notifies this state object when a pointer is lifted from anywhere
  void globalPointerUp(PointerUpEvent event) {
    if (pointers.count == 0) {
      isTransforming = false;
    }
  }

  @override
  void persist(Batch batch) {
    CanvasStatePersistor.persist(batch, this);
  }

  @override
  Future<void> rehydrate(Database db, BuildContext context) async {
    CanvasStateRehydrationResult result =
        await CanvasStatePersistor.rehydrate(db, context, this);

    _transform = result.transform;
  }
}
