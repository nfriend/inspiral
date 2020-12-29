import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

extension OffsetExtensions on Offset {
  Vector3 toVector3() {
    return Vector3(this.dx, this.dy, 0);
  }
}
