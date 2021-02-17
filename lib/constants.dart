import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// The global scaling factor for all sizes and position calculations
const double scaleFactor = 4;

/// The size of the drawable area
final Size canvasSize = Size(1000, 1000) * scaleFactor;

/// The canvas's origin
const Offset canvasOrigin = Offset.zero;

/// The canvas's center point
final Offset canvasCenter = canvasSize.center(canvasOrigin);

/// The number of columns to use when dividing the canvas into tiles
/// It's important that this number evenly divides `canvasSize.width`
const int tileColumnCount = 10;

/// The number of rows to use when dividing the canvas into tiles
/// It's important that this number evenly divides `canvasSize.height`
const int tileRowCount = 10;

/// The size of each tile
final Size tileSize = new Size(
    canvasSize.width / tileColumnCount, canvasSize.height / tileRowCount);

/// The size of the debug dots
final Size debugDotSize = Size(4, 4) * scaleFactor;

/// The size of the ink dot that renders inside the active gear hole
final Size inkDotSize = debugDotSize;

/// The length of each gear tooth
const double toothLength = 5;

/// The amount of padding added around each gear
/// to avoid lines being clipped
const double imagePadding = 0.25;

/// The smallest length of line segment to draw
const double minLineSegmentLength = 10;

/// The largest length of line segment to draw
const double maxLineSegmentLength = 20;

/// The default width of the line
const double defaultStokeWidth = 5;

/// The maximum allowed stroke width
const double maxStrokeWidth = 50;

/// The standard animation length for UI animations
const Duration uiAnimationDuration = Duration(milliseconds: 200);

/// These keys are used to fetch the RepaintBoundary parents of
/// the ink canvases. Used for screenshotting purposes.
final GlobalKey canvasWithoutBackgroundGlobalKey =
    GlobalKey(debugLabel: 'CanvasWithoutBackground');
final GlobalKey canvasWithBackgroundGlobalKey =
    GlobalKey(debugLabel: 'CanvasWithBackground');

/// The key used to fetch the instance of the ScaffoldMessenger
/// Used for showing snack bars.
final GlobalKey<ScaffoldMessengerState> scaffoldGlobalKey =
    GlobalKey(debugLabel: 'ScaffoldMessenger');

/// The size of thumbnail gear images (in logical pixels).
/// Thumbnail images are square, so only one dimension is needed.
/// This constant should equal its counterpart in `constants.ts`.
final double thumbnailSize = 65.0;
