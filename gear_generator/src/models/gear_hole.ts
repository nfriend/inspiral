import { Point } from './point';

export interface GearHole {
  /** The name of this hole that uniquely identifies it within the gear */
  name: string;

  /** The location of this hole, relative to the gear */
  point: Point;
}
