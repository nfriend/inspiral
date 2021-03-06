import 'package:vector_math/vector_math_64.dart';
import 'package:inspiral/util/quatrenion_slerp.dart' as util;

extension QuaternionExtensions on Quaternion {
  /// Slerp's between this Quaternion and the provided Quaternion.
  /// Returns a new `Quaternion` instance that represents the
  /// interpolation at time `t`.
  Quaternion slerp(Quaternion to, double t) {
    return util.slerp(this, to, t);
  }
}
