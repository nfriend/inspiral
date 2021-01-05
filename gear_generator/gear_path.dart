import 'dart:math';

/// A class that represents an SVG path of a gear
class GearPath {
  List<String> _commands = [];

  /// Moves the pen to the provided point
  GearPath moveTo(Point point, {bool absolute = true}) {
    _commands.add("${absolute ? "M" : "m"} ${point.x} ${point.y}");
    return this;
  }

  /// Draws a line to the provided point
  GearPath lineTo(Point point, {bool absolute = true}) {
    _commands.add("${absolute ? "L" : "l"} ${point.x} ${point.y}");
    return this;
  }

  /// Draws an elliptical arc curve
  GearPath arc(num radiusX, num radiusY, Point newPosition,
      {bool absolute = true}) {
    _commands.add(
        "${absolute ? "A" : "a"} $radiusX $radiusY 0 0 1 ${newPosition.x} ${newPosition.y}");
    return this;
  }

  /// Closes the path
  GearPath closePath() {
    _commands.add("Z");
    return this;
  }

  @override
  String toString() {
    return _commands.join(" ");
  }
}
