import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/util/get_center_of_mass.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';

class CanvasState extends ChangeNotifier {
  static CanvasState _instance;

  factory CanvasState.init({@required Matrix4 initialTransform}) {
    return _instance =
        CanvasState._internal(initialTransform: initialTransform);
  }

  factory CanvasState() {
    assert(_instance != null,
        'The CanvasState.init() factory constructor must be called before using the CanvasState() constructor.');
    return _instance;
  }

  CanvasState._internal({@required Matrix4 initialTransform}) {
    _transform = initialTransform;
  }

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
    _isTransforming = true;
  }

  /// Translates the view when either the app background or the
  /// empty canvas is moved.
  void appBackgroundOrCanvasMove(PointerMoveEvent event) {
    if (pointers.count == 1) {
      _applyTranslationTransform(event.delta);
    } else if (pointers.count == 2) {
      int pointer1 = pointers.activePointerIds.elementAt(0);
      int pointer2 = pointers.activePointerIds.elementAt(1);

      Line previousLine = Line(
          pointers.pointerPreviousPositions[pointer1].global,
          pointers.pointerPreviousPositions[pointer2].global);
      Line currentLine = Line(pointers.pointerPositions[pointer1].global,
          pointers.pointerPositions[pointer2].global);

      _applyTwoPointerTransform(previousLine, currentLine);
    } else {
      Offset previousCenterOfMass = getCenterOfMass(
          pointers.pointerPreviousPositions.values.map((p) => p.global));
      Offset currentCenterOfMass = getCenterOfMass(
          pointers.pointerPositions.values.map((p) => p.global));

      Offset delta = currentCenterOfMass - previousCenterOfMass;

      _applyTranslationTransform(delta);
    }
  }

  /// Notifies this state object when a pointer is lifted from
  /// either the app background or the canvas
  void appBackgroundOrCanvasUp(PointerUpEvent event) {
    if (pointers.count > 0) {
      _isTransforming = true;
    }
  }

  /// Translates the view by the provided offset
  void _applyTranslationTransform(Offset delta) {
    var transformUpdate = Matrix4.identity()..translate(delta.toVector3());
    transform = transformUpdate * transform;
  }

  /// Given two lines, computes and applies the transformation that should be
  /// applied to the canvas based on the difference between the two lines.
  void _applyTwoPointerTransform(Line previousLine, Line currentLine) {
    final pivotVector = previousLine.centerPoint().toVector3();

    var transformUpdate = Matrix4.identity();

    // Translate the pivot point to the origin
    transformUpdate.translate(pivotVector);

    // Scale
    double newScaleFactor = currentLine.length() / previousLine.length();
    transformUpdate.scale(newScaleFactor, newScaleFactor, 0);

    // Rotate
    transformUpdate.rotateZ(previousLine.angleTo(currentLine));

    // Put the origin back in the right spot
    transformUpdate.translate(-pivotVector);

    // Translate
    var translationVector =
        (currentLine.centerPoint() - previousLine.centerPoint()).toVector3();
    transformUpdate.translate(translationVector);

    // Apply the update to the current transformation
    transform = transformUpdate * transform;
  }
}
