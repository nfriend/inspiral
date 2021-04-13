import 'dart:ui';
import 'package:vector_math/vector_math_64.dart';
import 'package:inspiral/extensions/extensions.dart';

extension PathExtensions on Path {
  /// Returns a new `Path` instance, translated by `offset`
  Path translate(Offset offset) {
    var translation = Matrix4.translation(offset.toVector3()).storage;
    return transform(translation);
  }
}
