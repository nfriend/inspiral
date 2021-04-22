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
  beams: 20000,
  ovals: 30000,
  triangles: 40000,
  squares: 50000,
  pentagons: 60000,
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
  { radius: 100, holes: [0, ...range(8, 93)] },
  { radius: 144, holes: [0, ...range(8, 137)] },
  { radius: 150, holes: [0, ...range(8, 143)] },
];

const xToYRatio = 2 / 3;

/**
 * All the sizes of oval gears that should be generated
 */
export const ovalGearSizes = [
  { xRadius: 28, yRadius: 28 * xToYRatio, holes: [0, ...range(8, 16), 18, 22] },
  {
    xRadius: 36,
    yRadius: 36 * xToYRatio,
    holes: [0, ...range(8, 23), 26, 30],
  },
  {
    xRadius: 38,
    yRadius: 38 * xToYRatio,
    holes: [0, ...range(8, 24), 25, 26, 30, 34],
  },
  {
    xRadius: 47,
    yRadius: 47 * xToYRatio,
    holes: [0, ...range(8, 32), 33, 34, 38, 42],
  },
  {
    xRadius: 50,
    yRadius: 50 * xToYRatio,
    holes: [0, ...range(8, 32), 33, 34, 38, 42, 46],
  },
  {
    xRadius: 53,
    yRadius: 53 * xToYRatio,
    holes: [0, ...range(8, 36), 37, 38, 42, 46],
  },
  {
    xRadius: 57,
    yRadius: 57 * xToYRatio,
    holes: [0, ...range(8, 36), 37, 38, 39, 41, 42, 46, 50, 54],
  },
  {
    xRadius: 62,
    yRadius: 62 * xToYRatio,
    holes: [0, ...range(8, 40), 41, 42, 43, 46, 50, 54, 58],
  },
  {
    xRadius: 66,
    yRadius: 66 * xToYRatio,
    holes: [0, ...range(8, 44), 45, 46, 50, 54, 58, 62],
  },
  {
    xRadius: 71,
    yRadius: 71 * xToYRatio,
    holes: [0, ...range(8, 48), 49, 50, 54, 58, 62, 66],
  },
  {
    xRadius: 75,
    yRadius: 75 * xToYRatio,
    holes: [0, ...range(8, 48), 49, 50, 51, 53, 54, 58, 62, 66, 70],
  },
  {
    xRadius: 76,
    yRadius: 76 * xToYRatio,
    holes: [0, ...range(8, 48), 49, 50, 51, 53, 54, 58, 62, 66, 70],
  },
  {
    xRadius: 85,
    yRadius: 85 * xToYRatio,
    holes: [0, ...range(8, 56), 57, 58, 59, 61, 62, 66, 70, 74, 78],
  },
  {
    xRadius: 89,
    yRadius: 89 * xToYRatio,
    holes: [0, ...range(8, 56), 57, 58, 59, 61, 62, 63, 65, 66, 70, 74, 78, 82],
  },
  {
    xRadius: 95,
    yRadius: 95 * xToYRatio,
    holes: [0, ...range(8, 64), 65, 66, 67, 69, 70, 74, 78, 82, 86, 90],
  },
  {
    xRadius: 100,
    yRadius: 100 * xToYRatio,
    holes: [
      0,
      ...range(8, 64),
      65,
      66,
      67,
      69,
      70,
      71,
      73,
      74,
      78,
      82,
      86,
      90,
      94,
    ],
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
      { radius: 27, holes: [0, ...range(8, 17)] },
      { radius: 34, holes: [0, ...range(8, 23), 24] },
      { radius: 36, holes: [0, ...range(8, 26), 27] },
      { radius: 45, holes: [0, ...range(8, 34), 35, 38] },
      { radius: 48, holes: [0, ...range(8, 34), 35, 38] },
      { radius: 51, holes: [0, ...range(8, 39), 41, 46] },
      { radius: 54, holes: [0, ...range(8, 39), 40, 41, 43, 46] },
      { radius: 59, holes: [0, ...range(8, 45), 46] },
      { radius: 63, holes: [0, ...range(8, 47), 48, 49, 51, 54] },
      { radius: 68, holes: [0, ...range(8, 50), 51, 54, 62] },
      { radius: 71, holes: [0, ...range(8, 53), 54, 57, 59, 62] },
      { radius: 73, holes: [0, ...range(8, 55), 56, 57, 62] },
      { radius: 82, holes: [0, ...range(8, 63), 64, 65, 67, 70] },
      { radius: 85, holes: [0, ...range(8, 66), 67, 70, 78] },
      { radius: 91, holes: [0, ...range(8, 69), 70, 73, 75, 78] },
      { radius: 95, holes: [0, ...range(8, 74), 75, 78, 81, 86] },
    ],
    startingOrder: gearOrder.triangles,
  },
  {
    sides: 4,
    name: 'square',
    entitlement: 'io.nathanfriend.inspiral.squaregears',
    sizes: [
      { radius: 26, holes: [0, ...range(8, 21)] },
      { radius: 32, holes: [0, ...range(8, 25), 26] },
      { radius: 34, holes: [0, ...range(8, 27), 28] },
      { radius: 43, holes: [0, ...range(8, 35), 36, 38] },
      { radius: 45, holes: [0, ...range(8, 37), 28, 40] },
      { radius: 48, holes: [0, ...range(8, 39), 40, 42] },
      { radius: 51, holes: [0, ...range(8, 43), 44, 46] },
      { radius: 55, holes: [0, ...range(8, 45), 46, 48, 50] },
      { radius: 60, holes: [0, ...range(8, 51), 52, 54] },
      { radius: 64, holes: [0, ...range(8, 53), 54, 56, 58] },
      { radius: 67, holes: [0, ...range(8, 57), 58, 60, 62] },
      { radius: 68, holes: [0, ...range(8, 57), 58, 60, 62] },
      { radius: 77, holes: [0, ...range(8, 65), 66, 68, 70] },
      { radius: 80, holes: [0, ...range(8, 69), 70, 72, 74] },
      { radius: 85, holes: [0, ...range(8, 73), 74, 76, 78, 80] },
      { radius: 90, holes: [0, ...range(8, 77), 78, 80, 82, 84] },
    ],
    startingOrder: gearOrder.squares,
  },
  {
    sides: 5,
    name: 'pentagon',
    entitlement: 'io.nathanfriend.inspiral.pentagongears',
    sizes: [
      { radius: 25, holes: [0, ...range(8, 21)] },
      { radius: 31, holes: [0, ...range(8, 26)] },
      { radius: 33, holes: [0, ...range(8, 28)] },
      { radius: 42, holes: [0, ...range(8, 37), 38] },
      { radius: 44, holes: [0, ...range(8, 39)] },
      { radius: 47, holes: [0, ...range(8, 42)] },
      { radius: 50, holes: [0, ...range(8, 45), 46] },
      { radius: 54, holes: [0, ...range(8, 47)] },
      { radius: 58, holes: [0, ...range(8, 52), 54] },
      { radius: 62, holes: [0, ...range(8, 55)] },
      { radius: 66, holes: [0, ...range(8, 58), 59] },
      { radius: 67, holes: [0, ...range(8, 61), 62] },
      { radius: 75, holes: [0, ...range(8, 68), 70] },
      { radius: 78, holes: [0, ...range(8, 71)] },
      { radius: 83, holes: [0, ...range(8, 76), 78] },
      { radius: 87, holes: [0, ...range(8, 79)] },
    ],
    startingOrder: gearOrder.pentagons,
  },
];

export const beamSizes: {
  endCapRadius: number;
  length: number;
}[] = [
  { endCapRadius: 20, length: 50 },
  { endCapRadius: 20, length: 100 },
  { endCapRadius: 20, length: 194 },
  { endCapRadius: 20, length: 204 },
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
