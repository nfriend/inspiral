import range from 'lodash.range';

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
 * The starting order for each class of gear. The order
 * determines the order the gears are displayed in the app.
 */
export const gearOrder = {
  circles: 10000,
  ovals: 20000,
  triangles: 30000,
  squares: 40000,
  pentagons: 50000,
};

/**
 * All the sizes of circle gears that should be generated
 */
export const circleGearSizes = [
  { radius: 24, holes: [0, ...range(8, 17)] },
  { radius: 30, holes: [0, ...range(8, 23)] },
  { radius: 32, holes: [0, ...range(8, 25)] },
  { radius: 40, holes: [0, ...range(8, 33)] },
  { radius: 42, holes: [0, ...range(8, 35)] },
  { radius: 45, holes: [0, ...range(8, 38)] },
  { radius: 48, holes: [0, ...range(8, 41)] },
  { radius: 52, holes: [0, ...range(8, 45)] },
  { radius: 56, holes: [0, ...range(8, 49)] },
  { radius: 60, holes: [0, ...range(8, 53)] },
  { radius: 63, holes: [0, ...range(8, 56)] },
  { radius: 64, holes: [0, ...range(8, 57)] },
  { radius: 72, holes: [0, ...range(8, 65)] },
  { radius: 75, holes: [0, ...range(8, 68)] },
  { radius: 80, holes: [0, ...range(8, 73)] },
  { radius: 84, holes: [0, ...range(8, 77)] },
];

const xToYRatio = 2 / 3;

/**
 * All the sizes of oval gears that should be generated
 */
export const ovalGearSizes = [
  { xRadius: 24, yRadius: 24 * xToYRatio, holes: [0, ...range(8, 12), 13, 14] },
  {
    xRadius: 30,
    yRadius: 30 * xToYRatio,
    holes: [0, ...range(8, 16), 17, 18, 22],
  },
  { xRadius: 32, yRadius: 32 * xToYRatio, holes: [0, ...range(8, 20), 22] },
  {
    xRadius: 40,
    yRadius: 40 * xToYRatio,
    holes: [0, ...range(8, 24), 25, 26, 30],
  },
  {
    xRadius: 42,
    yRadius: 42 * xToYRatio,
    holes: [0, ...range(8, 24), 26, 27, 30, 34],
  },
  {
    xRadius: 45,
    yRadius: 45 * xToYRatio,
    holes: [0, ...range(8, 28), 29, 30, 31, 34],
  },
  { xRadius: 48, yRadius: 48 * xToYRatio, holes: [0, ...range(8, 32), 34, 38] },
  {
    xRadius: 52,
    yRadius: 52 * xToYRatio,
    holes: [0, ...range(8, 32), 34, 35, 38, 42],
  },
  {
    xRadius: 56,
    yRadius: 56 * xToYRatio,
    holes: [0, ...range(8, 36), 37, 38, 39, 42, 46],
  },
  {
    xRadius: 60,
    yRadius: 60 * xToYRatio,
    holes: [0, ...range(8, 36), 37, 38, 39, 41, 42, 46, 50],
  },
  {
    xRadius: 63,
    yRadius: 63 * xToYRatio,
    holes: [0, ...range(8, 40), 42, 43, 46, 50, 54],
  },
  {
    xRadius: 64,
    yRadius: 64 * xToYRatio,
    holes: [0, ...range(8, 40), 41, 42, 43, 45, 46, 50, 54],
  },
  {
    xRadius: 72,
    yRadius: 72 * xToYRatio,
    holes: [0, ...range(8, 44), 45, 46, 47, 50, 51, 54, 58, 62],
  },
  {
    xRadius: 75,
    yRadius: 75 * xToYRatio,
    holes: [0, ...range(8, 48), 49, 50, 51, 53, 54, 58, 62, 66],
  },
  {
    xRadius: 80,
    yRadius: 80 * xToYRatio,
    holes: [0, ...range(8, 52), 53, 54, 55, 58, 62, 66, 70],
  },
  {
    xRadius: 84,
    yRadius: 84 * xToYRatio,
    holes: [0, ...range(8, 52), 53, 54, 55, 58, 59, 61, 62, 66, 70, 74],
  },
];

/**
 * All the variations of polygons that should be rendered
 */
export const polygonVariations: {
  sides: number;
  name: string;
  entitlement: string;
  sizes: {
    radius: number;
    holes: number[];
  }[];
  startingOrder: number;
}[] = [
  {
    sides: 3,
    name: 'triangle',
    entitlement: 'io.nathanfriend.inspiral.trianglegears',
    sizes: [
      { radius: 24, holes: [0, ...range(8, 15)] },
      { radius: 30, holes: [0, ...range(8, 21), 22] },
      { radius: 32, holes: [0, ...range(8, 23)] },
      { radius: 40, holes: [0, ...range(8, 29), 30] },
      { radius: 42, holes: [0, ...range(8, 31)] },
      { radius: 45, holes: [0, ...range(8, 33), 38] },
      { radius: 48, holes: [0, ...range(8, 33), 38] },
      { radius: 52, holes: [0, ...range(8, 39), 46] },
      { radius: 56, holes: [0, ...range(8, 41), 46] },
      { radius: 60, holes: [0, ...range(8, 45), 46] },
      { radius: 63, holes: [0, ...range(8, 47), 54] },
      { radius: 64, holes: [0, ...range(8, 47), 48, 54] },
      { radius: 72, holes: [0, ...range(8, 53), 54, 62] },
      { radius: 75, holes: [0, ...range(8, 55), 56, 57, 59, 62] },
      { radius: 80, holes: [0, ...range(8, 58), 59, 60, 62, 70] },
      { radius: 84, holes: [0, ...range(8, 63), 64, 70] },
    ],
    startingOrder: gearOrder.triangles,
  },
  {
    sides: 4,
    name: 'square',
    entitlement: 'io.nathanfriend.inspiral.squaregears',
    sizes: [
      { radius: 24, holes: [0, ...range(8, 17)] },
      { radius: 30, holes: [0, ...range(8, 23)] },
      { radius: 32, holes: [0, ...range(8, 25)] },
      { radius: 40, holes: [0, ...range(8, 31), 32] },
      { radius: 42, holes: [0, ...range(8, 33), 34] },
      { radius: 45, holes: [0, ...range(8, 35), 36] },
      { radius: 48, holes: [0, ...range(8, 39), 40] },
      { radius: 52, holes: [0, ...range(8, 41), 42, 44] },
      { radius: 56, holes: [0, ...range(8, 47), 48] },
      { radius: 60, holes: [0, ...range(8, 49), 50, 52] },
      { radius: 63, holes: [0, ...range(8, 51), 52, 54] },
      { radius: 64, holes: [0, ...range(8, 51), 52, 54, 56] },
      { radius: 72, holes: [0, ...range(8, 59), 60, 62, 64] },
      { radius: 75, holes: [0, ...range(8, 57), 58, 59, 60, 61, 62, 64, 66] },
      { radius: 80, holes: [0, ...range(8, 65), 66, 68, 70, 72] },
      { radius: 84, holes: [0, ...range(8, 65), 66, 67, 68, 70, 72, 74] },
    ],
    startingOrder: gearOrder.squares,
  },
  {
    sides: 5,
    name: 'pentagon',
    entitlement: 'io.nathanfriend.inspiral.pentagongears',
    sizes: [
      { radius: 24, holes: [0, ...range(8, 17)] },
      { radius: 30, holes: [0, ...range(8, 23)] },
      { radius: 32, holes: [0, ...range(8, 25)] },
      { radius: 40, holes: [0, ...range(8, 33)] },
      { radius: 42, holes: [0, ...range(8, 34)] },
      { radius: 45, holes: [0, ...range(8, 38)] },
      { radius: 48, holes: [0, ...range(8, 41)] },
      { radius: 52, holes: [0, ...range(8, 45)] },
      { radius: 56, holes: [0, ...range(8, 49)] },
      { radius: 60, holes: [0, ...range(8, 52)] },
      { radius: 63, holes: [0, ...range(8, 55)] },
      { radius: 64, holes: [0, ...range(8, 56)] },
      { radius: 72, holes: [0, ...range(8, 63)] },
      { radius: 75, holes: [0, ...range(8, 66)] },
      { radius: 80, holes: [0, ...range(8, 71)] },
      { radius: 84, holes: [0, ...range(8, 74), 75] },
    ],
    startingOrder: gearOrder.pentagons,
  },
];

/** The scale factors to generate when rendering PNGs */
export const scalesToGenerate = [1, 1.5, 2, 3];

/** The radius of each hole */
export const holeSize = 2.5;

/**
 * The size of thumbnail gear images (in logical pixels).
 * Thumbnail images are square, so only one dimension is needed.
 * This constant should equal its counterpart in `constants.dart`.
 */
export const thumbnailSize = 65;
