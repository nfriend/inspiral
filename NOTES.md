# Notes

Current idea for a general-purpose gear algorithm:

Each gear implements an interface like this:

```dart
/// A 2D vector
class Vector {

  /// The x component of this vector
  double x;

  /// The y component of this vector
  double y;

  /// Adds this vector with another and returns
  /// the result as a new vector
  Vector add(Vector other);
}

/// An object that represents a specific point on the gear
class TouchPoint {

  /// The location of the point in 2D space
  Vector position;

  /// The angle of the tangent at the point, in radians
  double tangentAngle;

  /// Compares the `tangentAngle` of this TouchPoint
  /// to another and return the angle between them in radians
  double angleTo(TouchPoint other);

  /// Applies a rotation to this TouchPoint and returns the
  /// result as a new TouchPoint object
  TouchPoint rotate(angle);
}

/// A gear object
class Gear {

  /// Given an angle of the pointer, returns the current tooth count.
  /// Note that it's possible for `angle` to be greater than 2π; for
  /// example, if the user has dragged the pointer around 3 complete
  /// times, `angle` will be 6π. In this case, this function would
  /// return 3 times the total number of teeth on the gear.
  ///
  /// @param angle The angle of the of pointer, in radians
  double getToothFromAngle(double angle);

  /// Given a tooth, computes where the "touch point"
  /// on the gear should be (i.e. where another gear would intersect).
  /// Note that `tooth` is a `double`, because it can be fractional
  /// (e.g. a `tooth` of `5.5` would indicate half-way between
  /// tooth `5` and `6`).
  double getTouchPointFromTooth(double tooth)
}
```

When the pointer is dragged, the following is used to determine the position of
the free gear:

```dart
// Get the current angle of the point relative to the center of the fixed gear
double pointerAngle = getPointerAngle();

// Get the current tooth from the fixed gear
double currentTooth = fixedGear.getToothFromAngle(pointerAngle);

// Get the touch points from both gears
double fixedTouchPoint = fixedGear.getTouchPointFromTooth(currentTooth);
double freeTouchPoint = freeGear.getTouchPointFromTooth(currentTooth);

// Find the angle between the two touch points.
// This is how much the free gear needs to be rotated.
double rotation = fixedTouchPoint.angleTo(freeTouchPoint)

// Rotate the free gear's touch point by the rotation calculated above.
// This will result in the two TouchPoints being "aligned" (i.e.
// they have the same `tangentAngle`).
freeTouchPoint = freeTouchPoint.rotate(rotation)

// Then, add the two TouchPoint vectors. The resulting vector
// points to the center of the free gear
freeGearCenter = freeTouchPoint.position.add(fixedTouchPoint.position);
```
