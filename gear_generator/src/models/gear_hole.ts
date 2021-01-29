import { Point } from './point';

interface GearHole {
  /** The name of this hole that uniquely identifies it within the gear */
  name: string;

  /**
   * The angle (in radians) of where the text should be rendered, relative
   * to the position of the hole
   */
  textPositionAngle: number;

  /**
   * The angle (in radians) of how the text should be rotated, relative
   * to its default (no rotation)
   */
  textRotationAngle: number;
}

/**
 * A gear hole that defines its position using a relative
 * angle and distance from the gear's center.
 */
export interface AngleGearHole extends GearHole {
  /** The angle, in radians, of this hole relative to the gear's center */
  angle: number;

  /** The distance of this hole from the gear's center */
  distance: number;
}

/**
 * A gear hole that defines its position using a relative point
 */
export interface PointGearHole extends GearHole {
  /** The name of this hole that uniquely identifies it within the gear */
  name: string;

  /** The location of this hole, relative to the gear */
  point: Point;
}
