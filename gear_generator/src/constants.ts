import range from 'lodash.range';

interface BaseGearSize {
  /** The list of hole numbers that should be generated in this gear */
  holes: number[];

  /**
   * Whether or not this gears is a ring gear (i.e. its teeth appear
   * on the inside). Defaults to `false` if not provided.
   */
  isRing?: boolean;

  /**
   * An optional suffix to append to the file name/gear identifier.
   * User to disambiguate when two gears have the same shape and tooth count.
   */
  suffix?: string;
}

interface CircularGearSize extends BaseGearSize {
  radius: number;
}

interface OvalGearSize extends BaseGearSize {
  xRadius: number;
  yRadius: number;
}

interface BeamGearSize extends BaseGearSize {
  endCapRadius: number;
  length: number;
}

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
 * The thickness of ring gears
 */
export const ringGearWidth = 10.0;

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
export const circleGearSizes: CircularGearSize[] = [
  // Fixed
  { radius: 96, holes: [], isRing: true },
  { radius: 105, holes: [], isRing: true },
  { radius: 150, holes: [], isRing: true },
  { radius: 24, holes: [], suffix: 'noholes' },
  { radius: 30, holes: [], suffix: 'noholes' },
  { radius: 32, holes: [], suffix: 'noholes' },
  { radius: 40, holes: [], suffix: 'noholes' },
  { radius: 42, holes: [], suffix: 'noholes' },
  { radius: 45, holes: [], suffix: 'noholes' },
  { radius: 48, holes: [], suffix: 'noholes' },
  { radius: 52, holes: [], suffix: 'noholes' },
  { radius: 56, holes: [], suffix: 'noholes' },
  { radius: 60, holes: [], suffix: 'noholes' },
  { radius: 63, holes: [], suffix: 'noholes' },
  { radius: 64, holes: [], suffix: 'noholes' },
  { radius: 72, holes: [], suffix: 'noholes' },
  { radius: 75, holes: [], suffix: 'noholes' },
  { radius: 80, holes: [], suffix: 'noholes' },
  { radius: 84, holes: [], suffix: 'noholes' },
  { radius: 100, holes: [], suffix: 'noholes' },
  { radius: 144, holes: [], suffix: 'noholes' },
  { radius: 150, holes: [], suffix: 'noholes' },

  // Rotating
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
export const ovalGearSizes: OvalGearSize[] = [
  // Fixed
  { xRadius: 114, yRadius: 114 * xToYRatio, holes: [], isRing: true },
  { xRadius: 125, yRadius: 125 * xToYRatio, holes: [], isRing: true },
  { xRadius: 178, yRadius: 178 * xToYRatio, holes: [], isRing: true },
  { xRadius: 28, yRadius: 28 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 36, yRadius: 36 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 38, yRadius: 38 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 47, yRadius: 47 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 50, yRadius: 50 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 53, yRadius: 53 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 57, yRadius: 57 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 62, yRadius: 62 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 66, yRadius: 66 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 71, yRadius: 71 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 75, yRadius: 75 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 76, yRadius: 76 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 85, yRadius: 85 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 89, yRadius: 89 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 95, yRadius: 95 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 100, yRadius: 100 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 119, yRadius: 119 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 171, yRadius: 171 * xToYRatio, holes: [], suffix: 'noholes' },
  { xRadius: 178, yRadius: 178 * xToYRatio, holes: [], suffix: 'noholes' },

  // Rotating
  { xRadius: 28, yRadius: 28 * xToYRatio, holes: [0, ...range(8, 16), 18, 22] },
  { xRadius: 36, yRadius: 36 * xToYRatio, holes: [0, ...range(8, 23), 26, 30] },
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
  {
    xRadius: 119,
    yRadius: 119 * xToYRatio,
    holes: [
      0,
      ...range(8, 80),
      81,
      82,
      83,
      85,
      86,
      87,
      89,
      90,
      94,
      98,
      102,
      106,
      110,
      114,
    ],
  },
  {
    xRadius: 171,
    yRadius: 171 * xToYRatio,
    holes: [
      0,
      ...range(8, 112),
      113,
      114,
      115,
      117,
      118,
      119,
      121,
      122,
      123,
      125,
      126,
      127,
      129,
      130,
      134,
      138,
      142,
      146,
      150,
      154,
      158,
      162,
      166,
    ],
  },
  {
    xRadius: 178,
    yRadius: 178 * xToYRatio,
    holes: [
      0,
      ...range(8, 116),
      117,
      118,
      119,
      121,
      122,
      123,
      125,
      126,
      127,
      129,
      130,
      131,
      133,
      134,
      138,
      142,
      146,
      150,
      154,
      158,
      162,
      166,
      170,
      174,
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
  sizes: CircularGearSize[];
  startingOrder: number;
}[] = [
  {
    sides: 3,
    name: 'triangle',
    entitlement: 'io.nathanfriend.inspiral.trianglegears',
    sizes: [
      // Fixed
      { radius: 109, holes: [], isRing: true },
      { radius: 119, holes: [], isRing: true },
      { radius: 170, holes: [], isRing: true },
      { radius: 27, holes: [], suffix: 'noholes' },
      { radius: 34, holes: [], suffix: 'noholes' },
      { radius: 36, holes: [], suffix: 'noholes' },
      { radius: 45, holes: [], suffix: 'noholes' },
      { radius: 48, holes: [], suffix: 'noholes' },
      { radius: 51, holes: [], suffix: 'noholes' },
      { radius: 54, holes: [], suffix: 'noholes' },
      { radius: 59, holes: [], suffix: 'noholes' },
      { radius: 63, holes: [], suffix: 'noholes' },
      { radius: 68, holes: [], suffix: 'noholes' },
      { radius: 71, holes: [], suffix: 'noholes' },
      { radius: 73, holes: [], suffix: 'noholes' },
      { radius: 82, holes: [], suffix: 'noholes' },
      { radius: 85, holes: [], suffix: 'noholes' },
      { radius: 91, holes: [], suffix: 'noholes' },
      { radius: 95, holes: [], suffix: 'noholes' },
      { radius: 113, holes: [], suffix: 'noholes' },
      { radius: 163, holes: [], suffix: 'noholes' },
      { radius: 170, holes: [], suffix: 'noholes' },

      // Rotating
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
      { radius: 113, holes: [0, ...range(8, 87), 88, 89, 91, 94, 102] },
      {
        radius: 163,
        holes: [
          0,
          ...range(8, 125),
          126,
          128,
          129,
          131,
          134,
          137,
          139,
          142,
          150,
        ],
      },
      {
        radius: 170,
        holes: [
          0,
          ...range(8, 130),
          131,
          132,
          134,
          136,
          137,
          139,
          142,
          145,
          147,
          150,
          158,
        ],
      },
    ],
    startingOrder: gearOrder.triangles,
  },
  {
    sides: 4,
    name: 'square',
    entitlement: 'io.nathanfriend.inspiral.squaregears',
    sizes: [
      // Fixed
      { radius: 102, holes: [], isRing: true },
      { radius: 112, holes: [], isRing: true },
      { radius: 160, holes: [], isRing: true },
      { radius: 26, holes: [], suffix: 'noholes' },
      { radius: 32, holes: [], suffix: 'noholes' },
      { radius: 34, holes: [], suffix: 'noholes' },
      { radius: 43, holes: [], suffix: 'noholes' },
      { radius: 45, holes: [], suffix: 'noholes' },
      { radius: 48, holes: [], suffix: 'noholes' },
      { radius: 51, holes: [], suffix: 'noholes' },
      { radius: 55, holes: [], suffix: 'noholes' },
      { radius: 60, holes: [], suffix: 'noholes' },
      { radius: 64, holes: [], suffix: 'noholes' },
      { radius: 67, holes: [], suffix: 'noholes' },
      { radius: 68, holes: [], suffix: 'noholes' },
      { radius: 77, holes: [], suffix: 'noholes' },
      { radius: 80, holes: [], suffix: 'noholes' },
      { radius: 85, holes: [], suffix: 'noholes' },
      { radius: 90, holes: [], suffix: 'noholes' },
      { radius: 107, holes: [], suffix: 'noholes' },
      { radius: 154, holes: [], suffix: 'noholes' },
      { radius: 160, holes: [], suffix: 'noholes' },

      // Rotating
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
      { radius: 107, holes: [0, ...range(8, 91), 92, 94, 96, 98, 100] },
      {
        radius: 154,
        holes: [0, ...range(8, 133), 134, 136, 138, 140, 142, 144, 146, 148],
      },
      {
        radius: 160,
        holes: [0, ...range(8, 139), 140, 142, 144, 146, 148, 150, 152, 154],
      },
    ],
    startingOrder: gearOrder.squares,
  },
  {
    sides: 5,
    name: 'pentagon',
    entitlement: 'io.nathanfriend.inspiral.pentagongears',
    sizes: [
      // Fixed
      { radius: 100, holes: [], isRing: true },
      { radius: 109, holes: [], isRing: true },
      { radius: 156, holes: [], isRing: true },
      { radius: 25, holes: [], suffix: 'noholes' },
      { radius: 31, holes: [], suffix: 'noholes' },
      { radius: 33, holes: [], suffix: 'noholes' },
      { radius: 42, holes: [], suffix: 'noholes' },
      { radius: 44, holes: [], suffix: 'noholes' },
      { radius: 47, holes: [], suffix: 'noholes' },
      { radius: 50, holes: [], suffix: 'noholes' },
      { radius: 54, holes: [], suffix: 'noholes' },
      { radius: 58, holes: [], suffix: 'noholes' },
      { radius: 62, holes: [], suffix: 'noholes' },
      { radius: 66, holes: [], suffix: 'noholes' },
      { radius: 67, holes: [], suffix: 'noholes' },
      { radius: 75, holes: [], suffix: 'noholes' },
      { radius: 78, holes: [], suffix: 'noholes' },
      { radius: 83, holes: [], suffix: 'noholes' },
      { radius: 87, holes: [], suffix: 'noholes' },
      { radius: 104, holes: [], suffix: 'noholes' },
      { radius: 150, holes: [], suffix: 'noholes' },
      { radius: 156, holes: [], suffix: 'noholes' },

      // Rotating
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
      { radius: 104, holes: [0, ...range(8, 95)] },
      { radius: 150, holes: [0, ...range(8, 138), 139, 142] },
      { radius: 156, holes: [0, ...range(8, 143), 145, 150] },
    ],
    startingOrder: gearOrder.pentagons,
  },
];

export const beamSizes: BeamGearSize[] = [
  // Fixed
  { endCapRadius: 100, length: 79, holes: [], isRing: true },
  { endCapRadius: 100, length: 157, holes: [], isRing: true },
  { endCapRadius: 100, length: 245, holes: [], isRing: true },
  { endCapRadius: 20, length: 50, holes: [], suffix: 'noholes' },
  { endCapRadius: 20, length: 100, holes: [], suffix: 'noholes' },
  { endCapRadius: 20, length: 194, holes: [], suffix: 'noholes' },
  { endCapRadius: 20, length: 204, holes: [], suffix: 'noholes' },

  // Rotating
  {
    endCapRadius: 20,
    length: 50,
    holes: [0, ...range(14, 63, 8), ...range(10, 67, 8)],
  },
  {
    endCapRadius: 20,
    length: 100,
    holes: [0, ...range(14, 111, 8), ...range(10, 115, 8)],
  },
  {
    endCapRadius: 20,
    length: 194,
    holes: [0, ...range(14, 207, 8), ...range(10, 203, 8)],
  },
  {
    endCapRadius: 20,
    length: 204,
    holes: [0, ...range(14, 215, 8), ...range(10, 219, 8)],
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
