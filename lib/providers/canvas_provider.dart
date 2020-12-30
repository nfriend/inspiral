import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/providers/providers.dart';
import 'package:inspiral/extensions/extensions.dart';

class CanvasProvider extends ChangeNotifier {
  CanvasProvider({@required Matrix4 initialTransform}) {
    _transform = initialTransform;
  }

  PointersProvider pointers;

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

  /// Transforms device pixel coordinates into canvas coordinates, taking into
  /// account zoom, rotation, pan, and origin.
  Offset toCanvasCoordinates(Offset position, BuildContext context) {
    // Invert the Y axis so that it matched regular coordinate space
    var transformedPosition = Offset(position.dx, -position.dy);

    // Get the coordinates of the center of the screen
    final screenCenter = MediaQuery.of(context).size.centerPoint();

    // Move the origin to the center of the screen
    transformedPosition = Offset(transformedPosition.dx - screenCenter.dx,
        transformedPosition.dy + screenCenter.dy);

    // Apply the current transformation
    return MatrixUtils.transformPoint(transform, transformedPosition);
  }

  /// Transforms a position on the canvas into device pixel coordinates, taking
  /// into account zoom, rotation, pan, and origin.
  Offset toPixelCoordinates(Offset position, BuildContext context) {
    final invertedTransform = transform.clone();
    invertedTransform.invert();

    // Apply the current transformation in reverse
    var transformedPosition =
        MatrixUtils.transformPoint(invertedTransform, position);

    // Get the coordinates of the center of the screen
    final screenCenter = MediaQuery.of(context).size.centerPoint();

    // Move the origin to the top left corner of the screen
    transformedPosition = Offset(transformedPosition.dx + screenCenter.dx,
        transformedPosition.dy - screenCenter.dy);

    // Invert the Y axis so that it matches pixel coordinate space
    return Offset(transformedPosition.dx, -transformedPosition.dy);
  }

  void globalPointerDown(Offset pointerPosition, PointerDownEvent event) {
    if (pointers.count == 1) {
      pointer1Id = event.device;
      pointer1Position = event.position;
    } else if (pointers.count == 2) {
      pointer2Id = event.device;
      pointer2Position = event.position;
    }
  }

  void globalPointerMove(
      Offset pointerPosition, PointerMoveEvent event, BuildContext context) {
    if (isTransforming) {
      if (event.device == pointer1Id) {
        Line newLine = Line(point1: event.position, point2: pointer2Position);
        _updateTransform(pointerLine, newLine, context);
        pointer1Position = event.position;
      } else if (event.device == pointer2Id) {
        Line newLine = Line(point1: pointer1Position, point2: event.position);
        _updateTransform(pointerLine, newLine, context);
        pointer2Position = event.position;
      }
    }
  }

  void globalPointerUp(Offset pointerPosition, PointerUpEvent event) {
    if (pointers.count == 1) {
      pointer1Id = -1;
    } else if (pointers.count == 0) {
      pointer2Id = -1;
    }
  }

  /// Given two lines, computes and applies the transformation that should be
  /// applied to the canvas based on the difference between the two lines.
  void _updateTransform(Line previousLine, Line newLine, BuildContext context) {
    final pivotVector = newLine.centerPoint().toVector3();

    print("newLine: $newLine");
    print("pivotVector: $pivotVector");

    var newTransform = transform.clone();

    newTransform.translate(pivotVector);
    newTransform.rotateZ(previousLine.angleTo(newLine));
    newTransform.translate(-pivotVector);

    transform = newTransform;
  }
}
