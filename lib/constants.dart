import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const String appName = 'Inspiral';

/// The global scaling factor for all sizes and position calculations
const double scaleFactor = 4;

/// The canvas's origin
const Offset canvasOrigin = Offset.zero;

/// The number of columns to use when dividing the canvas into tiles
/// It's important that this number evenly divides `canvasSize.width`
const int tileColumnCount = 10;

/// The number of rows to use when dividing the canvas into tiles
/// It's important that this number evenly divides `canvasSize.height`
const int tileRowCount = 10;

/// The amount of padding to add to all sides of the canvas.
/// This padding allows gears to respond to pointer events even
/// when outside the canvas.
const double canvasPadding = 5000.0;

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
const double minLineSegmentLength = 5;

/// The largest length of line segment to draw
const double maxLineSegmentLength = 10;

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
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerGlobalKey =
    GlobalKey(debugLabel: 'ScaffoldMessenger');

/// The size of thumbnail gear images (in logical pixels).
/// Thumbnail images are square, so only one dimension is needed.
/// This constant should equal its counterpart in `constants.ts`.
const double thumbnailSize = 65.0;

/// The height of the top and bottom menu bars
const double menuBarHeight = 48.0;

/// The height of the selector drawer (the container for the gear, pen, and tool
/// options), in logical pixels.
const double selectorDrawerHeight = 168.0;

/// The name of the local SQLite database to use for persisting app state
const String localDatabaseName = 'inspiral.db';

/// The maximum zoom scale
const double maxScale = 2.0;

/// The minimum zoom scale
const double minScale = .05;
