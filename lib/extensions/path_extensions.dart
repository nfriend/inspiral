import 'dart:typed_data';
import 'dart:ui';
import 'package:vector_math/vector_math_64.dart';
import 'package:inspiral/extensions/extensions.dart';

extension PathExtensions on Path {
  /// Returns a new `Path` instance, translated by `offset`
  Path translate(Offset offset) {
    Float64List translation = Matrix4.translation(offset.toVector3()).storage;
    return this.transform(translation);
  }
}
