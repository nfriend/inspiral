import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

/// Converts a string formatted like `AARRGGBB` to a `Color`
Color colorFromHexString(String hexString) {
  return Color(int.parse(hexString, radix: 16));
}

/// Converts a string formatted like `AARRGGBB` to a `TinyColor`
TinyColor tinyColorFromHexString(String hexString) {
  return TinyColor(colorFromHexString(hexString));
}
