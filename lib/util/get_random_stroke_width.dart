import 'dart:math';

Random _rand = Random();

/// Gets a random stroke width
double getRandomStrokeWidth() {
  return 3 + _rand.nextDouble() * 47;
}
