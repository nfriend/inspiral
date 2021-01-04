import 'package:flutter/material.dart';

/// The size of the drawable area
const Size canvasSize = Size(2000, 2000);

/// The canvas's origin
const Offset canvasOrigin = Offset.zero;

/// The canvas's center point
final Offset canvasCenter = canvasSize.center(canvasOrigin);

/// The size of the debug dots
const Size debugDotSize = Size(16, 16);

/// The length of each gear tooth
const double toothLength = 6;
