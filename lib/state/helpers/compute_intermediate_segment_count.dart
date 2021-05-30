import 'dart:math';
import 'package:inspiral/constants.dart';
import 'package:vector_math/vector_math.dart';

/// Calculates how many intermediate points should be drawn between the last
/// point and the new point.
/// The method uses two different methods to guess at the ideal distance,
/// and picks the one that produces more points (= smoother lines).
/// The number of points drawn is a balancing act - more points
/// create smoother lines, but also trigger more baking processes = more UI jank.
/// Fewer points provide a smoother UX, but result in lower-quality lines.
///
/// @param distanceFromLastPoint The distance between the last & current points
/// @param angleDeltaMagnitude The change in angle between the two points
int computeIntermediateSegmentCount(
    {required double distanceFromLastPoint,
    required double angleDeltaMagnitude}) {
  return max(_computeByFixedAngle(angleDeltaMagnitude),
      _computeBySegmentLength(distanceFromLastPoint));
}

// This calculation method compares the previous angle to the current angle
// and ensures that a point is drawn every 6 degrees.
// 6 degrees is an arbitrary angle which seems to produce relatively
// smooth lines for most gear combinations.
// This method has one shortcoming: for very large gear pairings, 6 degrees is
// not granular enough to produce smooth lines.
int _computeByFixedAngle(double angleDeltaMagnitude) {
  assert(angleDeltaMagnitude >= 0,
      '`angleDeltaMagnitude` should not be negative. The provided delta should be the absolute value of the change.');

  return (angleDeltaMagnitude / (6.0 * degrees2Radians)).ceil();
}

// This calculation method looks at the distance between the last point
// and the new point, and divides the distance evenly so that each segment
// is no larger than the `maxLineSegmentLength` constant.
// This method also has a few shortcomings:
//   - If the two points are close together - for example, two points near the
//     the intersection of a loop - this algorithm may not draw enough points
//   - For very small designs, this algorithm may not draw enough points to
//     draw smooth lines
int _computeBySegmentLength(double distanceFromLastPoint) {
  assert(distanceFromLastPoint >= 0,
      '`distanceFromLastPoint` should not be negative. The provided distance should be the absolute value of the measurement.');

  return (distanceFromLastPoint / maxLineSegmentLength).ceil();
}
