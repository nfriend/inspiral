import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

extension OffsetExtensions on Offset {
  Vector3 toVector3() {
    return Vector3(dx, dy, 0);
  }

  // Returns a new Offset, rotated by `angle` around the provided point
  Offset rotated(double angle, Offset point) {
    var s = sin(angle);
    var c = cos(angle);

    var rotatedPosition = this;

    // Translate point to origin
    rotatedPosition -= point;

    // Rotate the point
    rotatedPosition = Offset(rotatedPosition.dx * c - rotatedPosition.dy * s,
        rotatedPosition.dx * s + rotatedPosition.dy * c);

    // Translate the point back
    rotatedPosition += point;

    return rotatedPosition;
  }

  /// Returns a new Offset, clamped within the provided bounds
  Offset clamp(Rect bounds) {
    return Offset(
      dx.clamp(bounds.left, bounds.right).toDouble(),
      dy.clamp(bounds.top, bounds.bottom).toDouble(),
    );
  }
}
