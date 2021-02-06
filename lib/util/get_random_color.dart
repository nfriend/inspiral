import 'dart:ui';
import 'dart:math';
import 'package:tinycolor/tinycolor.dart';

Random _rand = Random();

/// Gets a random color
Color getRandomColor() {
  return TinyColor.fromHSL(
          HslColor(h: _rand.nextDouble() * 360, s: 0.8, l: 0.5, a: 102.0))
      .color;
}
