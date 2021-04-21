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
  { radius: 100, holes: [0, ...range(8, 93)] },
  { radius: 150, holes: [0, ...range(8, 143)] },
  { radius: 250, holes: [0, ...range(8, 243)] },
];

const xToYRatio = 2 / 3;

/**
 * All the sizes of oval gears that should be generated
 */
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
      { radius: 24, holes: [0, ...range(8, 18)] },
      { radius: 30, holes: [0, ...range(8, 21), 22] },
      { radius: 32, holes: [0, ...range(8, 23)] },
      { radius: 40, holes: [0, ...range(8, 29), 30] },
      { radius: 42, holes: [0, ...range(8, 31)] },
      { radius: 45, holes: [0, ...range(8, 33), 38] },
      { radius: 48, holes: [0, ...range(8, 33), 38] },
      { radius: 52, holes: [0, ...range(8, 39), 46] },
      { radius: 56, holes: [0, ...range(8, 41), 46] },
      { radius: 60, holes: [0, ...range(8, 45), 46, 54] },
      { radius: 63, holes: [0, ...range(8, 47), 54] },
      { radius: 64, holes: [0, ...range(8, 47), 48, 54] },
      { radius: 72, holes: [0, ...range(8, 53), 54, 62] },
      { radius: 75, holes: [0, ...range(8, 57), 62] },
      { radius: 80, holes: [0, ...range(8, 58), 59, 60, 62, 70] },
      { radius: 84, holes: [0, ...range(8, 63), 64, 70, 78] },
      { radius: 100, holes: [0, ...range(8, 74), 75, 76, 78, 86, 94] },
      {
        radius: 150,
        holes: [0, ...range(8, 114), 115, 116, 118, 126, 134, 142],
      },
      {
        radius: 250,
        holes: [
          0,
          ...range(8, 194),
          195,
          196,
          198,
          200,
          201,
          203,
          206,
          209,
          211,
          214,
          222,
          230,
          238,
        ],
      },
    ],
    startingOrder: gearOrder.triangles,
  },
  {
    sides: 4,
    name: 'square',
    entitlement: 'io.nathanfriend.inspiral.squaregears',
    sizes: [],
    startingOrder: gearOrder.squares,
  },
  {
    sides: 5,
    name: 'pentagon',
    entitlement: 'io.nathanfriend.inspiral.pentagongears',
    sizes: [],
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
