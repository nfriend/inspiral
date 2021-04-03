import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  /// Converts this Color into a string representation like "AARRGGBB";
  String toHexString() {
    return value.toRadixString(16).padLeft(8, '0').toUpperCase();
  }
}
