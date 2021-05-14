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

/// The size of the outside of the "snap point" dots
final Size snapPointOuterSize = Size(7, 7) * scaleFactor;

/// The size of the inside of the "snap point" dots
final Size snapPointInnerSize = Size(4, 4) * scaleFactor;

/// How close to the snap points the fixed gear needs to be
/// in order to be snapped to its position
final double snapPointThreshold = 10.0 * scaleFactor;

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

/// The version of the local database file. Used for performing migrations.
const int localDatabaseVersion = 5;

/// The maximum zoom scale
const double maxScale = 2.0;

/// The minimum zoom scale
const double minScale = .05;

/// The number of path points we allow to build up in Path object before
/// the Paths are baked (rasterized) in the tile images in the canvas.
/// Large numbers of points cause the frame rate to drop (particularly on
/// low-end devices). However, the rasterization process itself causes
/// a noticeable jank. So this number can't be too high or too low. Too high,
/// and low-end devices will grind to a halt with lots of drawing. Too low, and
/// the experience begins to feel janky.
/// If https://github.com/flutter/flutter/issues/75755 is resolved, this
/// number can be lowered, because this should allow for the baking process
/// to complete in the background without affect the frame rate.
const int pointCountBakeThreshold = 1000;

/// It's possible for points to accumulate _during_ the baking process,
/// because the baking process is asynchronous. So the baking process
/// repeatedly calls itself until the points have been reduced to less
/// than this number.
const int pointCountBakeUntilThreshold = 100;
