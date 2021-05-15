import 'package:flutter/material.dart';
import 'package:inspiral/util/should_render_landscape_mode.dart';

/// Returns whether or not the screen is big enough to fit
/// the redo button in the menu bar. If it's not, it will be
/// rendered in the "Additional options" sidebar instead.
bool isScreenBigEnoughForRedoButton(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
  var threshold = 430;
  return shouldRenderLandscapeMode(context)
      ? screenSize.height > threshold
      : screenSize.width > threshold;
}
