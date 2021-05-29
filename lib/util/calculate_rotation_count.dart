/// Calculates the number of rotations necessary to draw a complete design,
/// given a fixed gear and a rotating gear
int calculateRotationCount(
    {required int fixedGearTeeth,
    required int rotatingGearTeeth,
    required double selectedHoleDistance,
    bool rotatingGearIsCircular = false}) {
  // If the rotating gear is round, and the hole is in position 0 (the very
  // center of the gear), we only need a single rotation to draw the complete
  // pattern, since the pattern will be a perfect circle. However, this only
  // applies to circular rotating gears - non-round gears cannot make this
  // assumption.
  if (selectedHoleDistance < 1 && rotatingGearIsCircular) {
    return 1;
  }

  var lcm = fixedGearTeeth *
      rotatingGearTeeth ~/
      fixedGearTeeth.gcd(rotatingGearTeeth);

  return lcm ~/ fixedGearTeeth;
}
