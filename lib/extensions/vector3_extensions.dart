import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

extension Vector3Extensions on Vector3 {
  /// Converts this Vector3 to an Offset
  Offset toOffset() {
    return Offset(x, y);
  }
}
