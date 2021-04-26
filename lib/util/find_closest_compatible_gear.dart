import 'package:inspiral/models/gears/gears.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/util/are_gears_compatible.dart';
import 'package:inspiral/util/gear_lists.dart';

/// If for some reason we can't find a compatible match
/// (which _should_ never happen), this is the gear to return instead.
GearDefinition _defaultGear = circle24;

/// Finds the closest compatible match to the fixed gear
/// given the currently selected rotating gear.
/// If the current selection is already compatible, this function
/// returns `currentlySelectedRotatingGear`.
GearDefinition findClosestCompatibleGear(
    {GearDefinition fixedGear, GearDefinition currentlySelectedRotatingGear}) {
  var currentlySelectedIndex =
      onlyGearsWithHoles.indexOf(currentlySelectedRotatingGear);
  if (currentlySelectedIndex == -1) {
    return _defaultGear;
  }

  // First, search backwards from the current selection
  for (var i = currentlySelectedIndex; i >= 0; i--) {
    var nextGearToCheck = onlyGearsWithHoles[i];

    if (areGearsCompatible(
        fixedGear: fixedGear, rotatingGear: nextGearToCheck)) {
      return nextGearToCheck;
    }
  }

  // No match yet? Search forward from the current selection instead.
  for (var i = currentlySelectedIndex + 1; i < onlyGearsWithHoles.length; i++) {
    var nextGearToCheck = onlyGearsWithHoles[i];

    if (areGearsCompatible(
        fixedGear: fixedGear, rotatingGear: nextGearToCheck)) {
      return nextGearToCheck;
    }
  }

  // Still no match? (Should never happen.) Return the default gear.
  return _defaultGear;
}
