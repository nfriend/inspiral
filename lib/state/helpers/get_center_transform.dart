import 'package:flutter/material.dart';
import 'package:inspiral/extensions/extensions.dart';

/// Returns a transform matrix that centers the canvas in the view
/// with no scale or rotation
Matrix4 getCenterTransform(
    {@required Size canvasSize, @required Size screenSize}) {
  // Compute an initial canvas translation that will place the
  // center point of the canvas directly in the center of the screen
  // By default, the canvas's top-left corner is lined up with
  // the screen's top-left corner
  var transform = Matrix4.identity();

  // Scale the canvas to the correct zoom level
  final initialZoom = 0.5;
  transform.scale(initialZoom, initialZoom, 0);

  // Move the center of the canvas to the
  // top-left of the screen. Multiplied by 2, because the
  // canvas itself is offset by `canvasCenter` from its parent.
  var canvasCenter = canvasSize.toOffset() / 2;
  var originTranslation = -(canvasCenter.toVector3() * 2);
  transform.translate(originTranslation);

  // Then, move the canvas back by half the screen dimensions
  // so that the centor of the canvas is located
  // in the center of the screen
  var centerTranslation = (screenSize / 2).toVector3() * (1 / initialZoom);
  transform.translate(centerTranslation);

  return transform;
}
