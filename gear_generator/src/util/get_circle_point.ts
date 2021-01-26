import { Point } from '../models/point';

export interface GetCirclePointParams {
  center: Point;
  radius: number;
  angle: number;
}

/** Gets a point on a circle at a specific angle */
export const getCirclePoint = ({
  center,
  radius,
  angle,
}: GetCirclePointParams): Point => {
  return {
    x: radius * Math.cos(angle) + center.x,
    y: -1 * radius * Math.sin(angle) + center.y,
  };
};
