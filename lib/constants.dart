import 'package:flutter/material.dart';

/// The global scaling factor for all sizes and position calculations
const double scaleFactor = 4;

/// The size of the drawable area
final Size canvasSize = Size(1000, 1000) * scaleFactor;

/// The canvas's origin
const Offset canvasOrigin = Offset.zero;

/// The canvas's center point
final Offset canvasCenter = canvasSize.center(canvasOrigin);

/// The size of the debug dots
final Size debugDotSize = Size(2, 2) * scaleFactor;

/// The length of each gear tooth
const double toothLength = 5;

/// The amount of padding added around each gear
/// to avoid lines being clipped
const double imagePadding = 0.25;
