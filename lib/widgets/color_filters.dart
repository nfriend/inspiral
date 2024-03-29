import 'dart:ui';
import 'package:flutter/material.dart';

final noFilterColorFilter = ColorFilter.matrix([
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);

final invertColorFilter = ColorFilter.matrix([
  -1,
  0,
  0,
  0,
  255,
  0,
  -1,
  0,
  0,
  255,
  0,
  0,
  -1,
  0,
  255,
  0,
  0,
  0,
  1,
  0,
]);

final fixedGearColorFilter = ColorFilter.matrix([
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1.5,
  0,
]);

final fixedGearInvertedColorFilter = ColorFilter.matrix([
  -1,
  0,
  0,
  0,
  255,
  0,
  -1,
  0,
  0,
  255,
  0,
  0,
  -1,
  0,
  255,
  0,
  0,
  0,
  2,
  0,
]);

final activeThumbnailGearColorFilter = ColorFilter.matrix([
  1.3,
  0,
  0,
  0,
  0,
  0,
  1.3,
  0,
  0,
  0,
  0,
  0,
  1.3,
  0,
  0,
  0,
  0,
  0,
  2.0,
  0,
]);

final disabledThumbnailGearColorFilter = ColorFilter.matrix([
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  0.3,
  0,
]);
