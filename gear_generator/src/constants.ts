/**
 * The height of each tooth
 */
export const toothHeight = 5;

/**
 * How much breathing room should be added between the gears
 */
export const meshSpacing = 1.0;

/**
 * How many pixels should be rendered for each SVG unit
 * while generating the lowest-resolution version
 */
export const baseScale = 4;

/**
 * The amount of padding to add around each side of the image.
 * (Without padding, the stroke bleeds off the image edge.)
 * This should equal the stroke width of the generated SVG.
 */
export const padding = 0.25;

/**
 * All the sizes of circle gears that should be generated
 */
export const circleGearSizes = [
  24,
  30,
  32,
  40,
  42,
  45,
  48,
  52,
  56,
  60,
  63,
  64,
  72,
  75,
  80,
  84,
];

/**
 * All the sizes of oval gears that should be generated
 */
const xToYRatio = 2 / 3;
export const ovalGearSizes = [
  { xRadius: 24, yRadius: 24 * xToYRatio },
  { xRadius: 30, yRadius: 30 * xToYRatio },
  { xRadius: 32, yRadius: 32 * xToYRatio },
  { xRadius: 40, yRadius: 40 * xToYRatio },
  { xRadius: 42, yRadius: 42 * xToYRatio },
  { xRadius: 45, yRadius: 45 * xToYRatio },
  { xRadius: 48, yRadius: 48 * xToYRatio },
  { xRadius: 52, yRadius: 52 * xToYRatio },
  { xRadius: 56, yRadius: 56 * xToYRatio },
  { xRadius: 60, yRadius: 60 * xToYRatio },
  { xRadius: 63, yRadius: 63 * xToYRatio },
  { xRadius: 72, yRadius: 72 * xToYRatio },
  { xRadius: 75, yRadius: 75 * xToYRatio },
  { xRadius: 80, yRadius: 80 * xToYRatio },
  { xRadius: 84, yRadius: 84 * xToYRatio },
];

/** The scale factors to generate when rendering PNGs */
export const scalesToGenerate = [1, 2, 3];

/** The radius of each hole */
export const holeSize = 2.5;

/**
 * The size of thumbnail gear images (in logical pixels).
 * Thumbnail images are square, so only one dimension is needed.
 * This constant should equal its counterpart in `constants.dart`.
 */
export const thumbnailSize = 75;
