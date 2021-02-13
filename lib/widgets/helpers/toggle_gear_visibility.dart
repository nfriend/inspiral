import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

/// Shows or hides the gears in the UI
void toggleGearVisiblity(BuildContext context) {
  var rotatingGear = Provider.of<RotatingGearState>(context, listen: false);
  var fixedGear = Provider.of<FixedGearState>(context, listen: false);

  fixedGear.isVisible = !fixedGear.isVisible;
  rotatingGear.isVisible = !rotatingGear.isVisible;
}
