import 'dart:collection';

import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/models/gears/gears.dart';

/// Determines if two gears are compatible (i.e. they will not overlap
/// in physically impossible ways).
bool areGearsCompatible(
    {required GearDefinition fixedGear, required GearDefinition rotatingGear}) {
  return fixedGear.biggestConcaveDiff <= rotatingGear.smallestConvexDiff &&
      rotatingGear.biggestConcaveDiff <= fixedGear.smallestConvexDiff &&
      _testSpecialCases(fixedGear: fixedGear, rotatingGear: rotatingGear);
}

final _incompatibleMapping = <GearDefinition, HashSet<GearDefinition>>{
  circle42Ring: HashSet.from([circle40]),
  circle45Ring: HashSet.from([circle40, circle42]),
  circle48Ring: HashSet.from([circle42, circle45]),
  circle52Ring: HashSet.from([circle45, circle48]),
  circle56Ring: HashSet.from([circle52]),
  circle60Ring: HashSet.from([circle56]),
  circle63Ring: HashSet.from([circle56, circle60]),
  circle64Ring: HashSet.from([circle60]),
  circle75Ring: HashSet.from([circle72]),
  circle80Ring: HashSet.from([circle75]),
  circle84Ring: HashSet.from([circle80]),
  circle105Ring: HashSet.from([circle100]),
  circle150Ring: HashSet.from([circle144]),
  oval125Ring: HashSet.from([circle52]),
  squareRing105: HashSet.from([circle100]),
  squareRing79: HashSet.from([circle75]),
  squareRing55: HashSet.from([circle52]),
  squareRing505: HashSet.from([circle48, circle45]),
  squareRing44: HashSet.from([circle42, circle40]),
  pentagonRing495: HashSet.from([
    circle100,
  ]),
  pentagonRing54: HashSet.from([
    circle75,
    circle72,
  ]),
  pentagonRing775: HashSet.from([circle52]),
  pentagonRing103: HashSet.from([circle48, circle45]),
  pentagonRing132: HashSet.from([
    circle42,
    circle40,
  ]),
  waveCircleRing: HashSet.from([circle42]),
};

/// The algorithm above works _most_ of the time, but it breaks down in a few
/// situations - particularly with ring gears paired with circular gears of a
/// very similar tooth count. This function handles these combinations on a
/// case-by-case basis. There may be a way to make the algorithm above smarter
/// to handle these cases, but this was the quickest/easiest way.
bool _testSpecialCases(
    {required GearDefinition fixedGear, required GearDefinition rotatingGear}) {
  return !(_incompatibleMapping.containsKey(fixedGear) &&
      _incompatibleMapping[fixedGear]!.contains(rotatingGear));
}
