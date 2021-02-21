import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
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

  /// The "device ID" of the first pointer
  int pointer1Id = -1;

  /// The "device ID" of the second pointer
  int pointer2Id = -1;

  /// The last location of pointer 1
  Offset pointer1Position = Offset.zero;

  /// The last location of pointer 2
  Offset pointer2Position = Offset.zero;

  /// Whether or not the canvas is being panned/rotated/zoomed
  bool get isTransforming =>
      pointer1Id > -1 && pointer2Id > -1 && pointers.count == 2;

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

  void globalPointerDown(PointerDownEvent event) {
    if (pointers.count == 1) {
      pointer1Id = event.device;
      pointer1Position = event.position;
    } else if (pointers.count == 2) {
      pointer2Id = event.device;
      pointer2Position = event.position;
    }
  }

  void globalPointerMove(PointerMoveEvent event) {
    if (isTransforming &&
        (event.device == pointer1Id || event.device == pointer2Id)) {
      final previousLine = Line(pointer1Position, pointer2Position);
      Line currentLine;

      if (event.device == pointer1Id) {
        currentLine = Line(event.position, pointer2Position);
      } else {
        currentLine = Line(pointer1Position, event.position);
      }

      _updateTransform(previousLine, currentLine);
    }

    // Always update the last coordinates of the pointers,
    // even if we're not currently transforming.
    if (event.device == pointer1Id) {
      pointer1Position = event.position;
    } else if (event.device == pointer2Id) {
      pointer2Position = event.position;
    }
  }

  void globalPointerUp(PointerUpEvent event) {
    if (pointers.count == 1) {
      // If we're transitioning from two fingers down to one

      if (event.device == pointer1Id) {
        // If the finder that was lifted was pointer1, reassign pointer2 to pointer1
        pointer1Id = pointer2Id;
        pointer1Position = pointer2Position;
      }

      pointer2Id = -1;
    } else if (pointers.count == 0) {
      // If we're transitioning from one finger down to none

      pointer1Id = -1;
    }
  }

  /// Given two lines, computes and applies the transformation that should be
  /// applied to the canvas based on the difference between the two lines.
  void _updateTransform(Line previousLine, Line currentLine) {
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
