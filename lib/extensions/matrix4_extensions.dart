import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:inspiral/extensions/extensions.dart';

/// Represents the individual 2D transformations of a Matrix4
@immutable
class Matrix4TransformDecomposition {
  final Offset translation;
  final double scale;
  final Quaternion quaternion;

  double get rotation {
    if (quaternion.z < 0) {
      // If the z-axis is negative, invert all the components. This represents
      // the same angle, but now the angle around z-axis is expressed
      // in the way we expect.
      return Quaternion(
              -quaternion.x, -quaternion.y, -quaternion.z, -quaternion.w)
          .radians;
    } else {
      return quaternion.radians;
    }
  }

  Matrix4TransformDecomposition(
      {@required this.translation,
      @required this.scale,
      @required this.quaternion});

  /// Interpolates between this set of transforms and the provided set
  Matrix4TransformDecomposition interpolateTo(
      Matrix4TransformDecomposition to, double t) {
    return Matrix4TransformDecomposition(
        translation: this.translation * (1.0 - t) + to.translation * t,
        scale: this.scale * (1.0 - t) + to.scale * t,
        quaternion: this.quaternion.slerp(to.quaternion, t));
  }
}

extension Matrix4Extensions on Matrix4 {
  /// Interpolates this `Matrix4` to the provided `Matrix4`.
  Matrix4 interpolateTo(Matrix4 to, double t) {
    Matrix4TransformDecomposition deltas =
        this.decompose2D().interpolateTo(to.decompose2D(), t);

    return Matrix4.compose(deltas.translation.toVector3(), deltas.quaternion,
        Vector3(deltas.scale, deltas.scale, 1.0));
  }

  /// Breaks down this `Matrix4` into its individual tranform components.
  Matrix4TransformDecomposition decompose2D() {
    Vector3 decomposedTranslation = Vector3.zero();
    Vector3 decomposedScale = Vector3.zero();
    Quaternion decomposedRotation = Quaternion.identity();
    PointerEvent.removePerspectiveTransform(this)
        .decompose(decomposedTranslation, decomposedRotation, decomposedScale);

    return Matrix4TransformDecomposition(
        translation: decomposedTranslation.toOffset(),
        scale: decomposedScale.x,
        quaternion: decomposedRotation);
  }
}
