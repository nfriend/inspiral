import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

extension SizeExtensions on Size {
  /// Returns this size as an offset
  /// (where x = width, y = height)
  Offset toOffset() {
    return Offset(width, height);
  }

  /// Converts this size to a Vector3
  Vector3 toVector3() {
    return Vector3(width, height, 0);
  }
}
