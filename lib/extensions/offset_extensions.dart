import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

extension OffsetExtensions on Offset {
  Vector3 toVector3() {
    return Vector3(this.dx, this.dy, 0);
  }

  // Returns a new Offset, rotated by `angle` around the provided point
  Offset rotated(double angle, Offset point) {
    double s = sin(angle);
    double c = cos(angle);

    Offset rotatedPosition = this;

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
      this.dx.clamp(bounds.left, bounds.right),
      this.dy.clamp(bounds.top, bounds.bottom),
    );
  }
}
