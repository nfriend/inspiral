import { Point } from './point';

export interface ContactPoint {
  /** The position of this contact point */
  position: Point;

  /** The direction of this contact point */
  direction: number;
}
