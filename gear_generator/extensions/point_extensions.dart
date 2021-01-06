import 'dart:math';

extension PointExtensions on Point {
  Point operator /(double scale) {
    return Point(this.x / scale, this.y / scale);
  }

  Point operator *(double scale) {
    return Point(this.x * scale, this.y * scale);
  }
}
