import { Point } from './point';

/**
 * A class that represents an SVG path of a gear
 */
export class GearPath {
  public commands: string[] = [];

  /** Moves the pen to the provided point */
  moveTo(point: Point, absolute = true): GearPath {
    this.commands.push(`${absolute ? 'M' : 'm'} ${point.x} ${point.y}`);
    return this;
  }

  /** Draws a line to the provided point */
  lineTo(point: Point, absolute = true): GearPath {
    this.commands.push(`${absolute ? 'L' : 'l'} ${point.x} ${point.y}`);
    return this;
  }

  /** Draws an elliptical arc curve */
  arc(
    radiusX: number,
    radiusY: number,
    newPosition: Point,
    absolute = true,
  ): GearPath {
    this.commands.push(
      `${absolute ? 'A' : 'a'} ${radiusX} ${radiusY} 0 0 1 ${newPosition.x} ${
        newPosition.y
      }`,
    );
    return this;
  }

  /** Closes the path */
  closePath(): GearPath {
    this.commands.push('Z');
    return this;
  }
}

GearPath.prototype.toString = function () {
  return this.commands.join(' ');
};
