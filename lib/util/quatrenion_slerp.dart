import 'dart:math';

import 'package:vector_math/vector_math_64.dart';

// The smallest positive `double` value that is greater than zero.
const double _epsilon = 4.94065645841247E-324;

/// `slerp`s between two quaternions.
/// Returns a new `Quaternion` instance that represents the
/// interpolation at time `t`.
///
/// Based on three.js's implementation:
/// https://github.com/mrdoob/three.js/blob/f23d9e0896ae10c09dee289f79d0ce8e283e367e/src/math/Quaternion.js#L534
Quaternion slerp(Quaternion qa, Quaternion qb, double t) {
  qa = qa.clone();
  qb = qb.clone();

  if (t == 0.0) return qa;
  if (t == 1.0) return qb;

  final x = qa.x, y = qa.y, z = qa.z, w = qa.w;

  var cosHalfTheta = w * qb.w + x * qb.x + y * qb.y + z * qb.z;

  if (cosHalfTheta < 0.0) {
    qa.setValues(-qb.x, -qb.y, -qb.z, -qb.w);
    cosHalfTheta = -cosHalfTheta;
  } else if (cosHalfTheta >= 1.0) {
    return qa;
  } else {
    qa = qb.clone();
  }

  final sqrSinHalfTheta = 1.0 - cosHalfTheta * cosHalfTheta;

  if (sqrSinHalfTheta <= _epsilon) {
    final s = 1 - t;
    qa.setValues(
        s * x + t * qa.x, s * y + t * qa.y, s * z + t * qa.z, s * w + t * qa.w);
    qa.normalize();

    return qa;
  }

  final sinHalfTheta = sqrt(sqrSinHalfTheta);
  final halfTheta = atan2(sinHalfTheta, cosHalfTheta);
  final ratioA = sin((1 - t) * halfTheta) / sinHalfTheta;
  final ratioB = sin(t * halfTheta) / sinHalfTheta;

  qa.setValues(x * ratioA + qa.x * ratioB, y * ratioA + qa.y * ratioB,
      z * ratioA + qa.z * ratioB, w * ratioA + qa.w * ratioB);

  return qa;
}
