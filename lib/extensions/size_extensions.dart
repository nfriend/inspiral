import 'package:flutter/material.dart';

extension SizeExtensions on Size {
  /// Gets the center point of the size
  /// (half the width, half the height).
  Offset centerPoint() {
    return Offset(this.width / 2, this.height / 2);
  }
}
