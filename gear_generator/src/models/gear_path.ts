import { Point } from './point';

/**
 * A class that represents an SVG path of a gear
 */
export class GearPath {
  public commands: string[] = [];

  /** Moves the pen to the provided point */
  moveTo({
    point,
    absolute = true,
  }: {
    point: Point;
    absolute?: boolean;
  }): GearPath {
    this.commands.push(`${absolute ? 'M' : 'm'} ${point.x} ${point.y}`);
    return this;
  }

  /** Draws a line to the provided point */
  lineTo({
    point,
    absolute = true,
  }: {
    point: Point;
    absolute?: boolean;
  }): GearPath {
    this.commands.push(`${absolute ? 'L' : 'l'} ${point.x} ${point.y}`);
    return this;
  }

  /** Draws an elliptical arc curve */
  arc({
    radiusX,
    radiusY,
    newPosition,
    xAxisRotation = 0,
    largeArcFlag = false,
    sweepFlag = false,
    absolute = true,
  }: {
    radiusX: number;
    radiusY: number;
    newPosition: Point;
    xAxisRotation?: number;
    largeArcFlag?: boolean;
    sweepFlag?: boolean;
    absolute?: boolean;
  }): GearPath {
    const commandPieces = [
      absolute ? 'A' : 'a',
      radiusX,
      radiusY,
      xAxisRotation,
      largeArcFlag ? 1 : 0,
      sweepFlag ? 1 : 0,
      newPosition.x,
      newPosition.y,
    ];

    this.commands.push(commandPieces.join(' '));

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
