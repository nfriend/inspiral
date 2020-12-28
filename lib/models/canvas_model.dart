import 'package:flutter/material.dart';
import 'package:inspiral/models/line.dart';
import 'package:inspiral/models/pointer_model.dart';

class CanvasModel extends ChangeNotifier {
  CanvasModel({double initialRotation, double initialZoom}) {
    this._rotation = initialRotation;
    this.zoom = initialZoom;
  }

  PointersModel pointers;

  double _rotation = 0;

  /// The current rotation of the canvas, in radians
  double get rotation => _rotation;
  set rotation(double value) {
    _rotation = value;
    notifyListeners();
  }

  /// The current zoom level
  double zoom;

  /// The "device ID" of the first pointer
  int pointer1Id = -1;

  /// The "device ID" of the second pointer
  int pointer2Id = -1;

  Offset _pointer1Position = Offset(0, 0);

  /// The last location of pointer 1
  Offset get pointer1Position => _pointer1Position;
  set pointer1Position(Offset value) {
    _pointer1Position = value;
    pointerLine = Line(point1: pointer1Position, point2: pointer2Position);
  }

  Offset _pointer2Position = Offset(0, 0);

  /// The last location of pointer 2
  Offset get pointer2Position => _pointer2Position;
  set pointer2Position(Offset value) {
    _pointer2Position = value;
    pointerLine = Line(point1: pointer1Position, point2: pointer2Position);
  }

  /// The line between the two pointers
  Line pointerLine;

  /// Whether or not the canvas is being panned/rotated/zoomed
  bool get isTransforming =>
      pointer1Id > -1 && pointer2Id > -1 && pointers.count == 2;

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
    if (isTransforming) {
      if (event.device == pointer1Id) {
        Line newLine = Line(point1: event.position, point2: pointer2Position);
        _transform(pointerLine, newLine);
        pointer1Position = event.position;
      } else if (event.device == pointer2Id) {
        Line newLine = Line(point1: pointer1Position, point2: event.position);
        _transform(pointerLine, newLine);
        pointer2Position = event.position;
      }
    }
  }

  void globalPointerUp(PointerUpEvent event) {
    if (pointers.count == 1) {
      pointer1Id = -1;
    } else if (pointers.count == 0) {
      pointer2Id = -1;
    }
  }

  /// Given two lines, computes and applies the transformation that should be
  /// applied to the canvas based on the difference between the two lines.
  void _transform(Line previousLine, Line newLine) {
    // TODO: make sure this is always in correct range
    rotation += previousLine.angleTo(newLine);
  }
}
