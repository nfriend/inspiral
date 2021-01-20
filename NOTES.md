# Notes

## Generic SVG-based gear definitions

**Idea:** Define gear with an SVG path.

### Implementation:

Each gear object looks like this:

```dart
class GearPoint {

  /// The position of this point
  Point position;

  /// Gets the "direction of the point
  /// (This might be called the "normal" line?)
  double direction;

  /// How far along the rotation we are in terms of path length.
  /// e.g. If the total path lenght is 100 units, and the length
  /// of the path up to this point is 75 units, this is .75
  double rotationFraction;

  /// The angle of this point, relative to the gear's center point.
  double angle;
}

class Gear {
  /// The total number of teeth in this gear
  int toothCount;

  /// The list of individual line segments that define
  /// the gear's shape and rotation behavior
  List<GearPoint> points;
}
```

## Runtime rotation function

1. The rotating gear is dragged
1. The angle between the mouse and the center of the fixed gear is computed
1. The closest `GearPoint` on the fixed gear is found by doing a binary search through `fixedGear.points` for the `GearPoint` with the closest `angle`
1. The `GearPoint` is mapped to a tooth: `currentTooth = gearPoint.rotationFraction * fixedGear.toothCount`
1. The resulting tooth is used to find the rotating's gear `GearPoint` using another binary search through `rotatingGear.points`.
   1. The tooth is translated into a `rotationFraction`: `rotationFraction = currentTooth / rotatingGear.toothCount`
   1. The `GearPoint` with the closest `rotationFraction` is selected

## Generating the gears

1. Take advantage of WebKit's SVG implemention. Using headless Chrome, load in an SVG path.
1. Use the [`getPointAtLength`](https://developer.mozilla.org/en-US/docs/Web/API/SVGPathElement/getPointAtLengthhttps://developer.mozilla.org/en-US/docs/Web/API/SVGPathElement/getPointAtLength) function to step around the path in tiny increments (~1000 increments minimum) to generate each `GearPoint`.
1. Save this list of `GearPoint`s in some kind of format the app can understand.

## Questions to answer

- Is there any reason to compute `angle` "separately" from `rotationFraction`? Just using `rotationFraction` as a proxy for `angle` might be good enough (or maybe even better) for most cases.
