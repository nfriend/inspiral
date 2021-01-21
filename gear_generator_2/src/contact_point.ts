import { Point } from './point';

export interface ContactPoint {
  /** The position of this contact point */
  p: Point;

  /** The direction of this contact point */
  d: number;
}
