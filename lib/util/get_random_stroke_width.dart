import 'dart:math';

Random _rand = Random();

/// Gets a random stroke width.
/// Biased towards smaller strokes.
double getRandomStrokeWidth() {
  double maxRandom = 22;
  return 3 +
      (_rand.nextDouble() * maxRandom - _rand.nextDouble() * maxRandom).abs();
}
