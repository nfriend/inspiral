import 'package:tinycolor/tinycolor.dart';
import 'package:inspiral/extensions/extensions.dart';

extension TinyColorExtensions on TinyColor {
  /// Converts this TinyColor into a string representation like "AARRGGBB";
  String toHexString() => color.toHexString();
}
