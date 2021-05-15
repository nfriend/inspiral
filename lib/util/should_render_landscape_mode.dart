import 'package:flutter/material.dart';

/// Returns whether or not to render in "landscape mode", i.e. render the
/// menu bar and tools drawer on the left and right sides. This mode is a bit
/// awkward, so for screens that are big enough (like iPads), we keep
/// the regular layout in both orientations.
bool shouldRenderLandscapeMode(BuildContext context) {
  var mediaQueryData = MediaQuery.of(context);
  var isLandscape = mediaQueryData.orientation == Orientation.landscape;
  var screenHeight = mediaQueryData.size.height;

  // 600 is an arbitrary number. An iPhone 5s has a screen height of 568
  // logical pixels, and the app feels a bit cramped on a 5s, so 600 is
  // just a bit bigger than this.
  return isLandscape && screenHeight < 600;
}
