import { Point } from './point';

export type ClipType = 'oval' | 'path' | 'none';

/**
 * Describes a "clip" shape. Used to generate a custom Clipper class
 * for a gear in order to limit its hit test area.
 */
export interface Clip {
  type: 'oval' | 'path';
}

export interface OvalClip extends Clip {
  type: 'oval';
  centerPoint: Point;
  width: number;
  height: number;
}

export interface PathClip extends Clip {
  type: 'path';

  /**
   * `commands` is an array of SVG path commands.
   * Its format matches the output of `parse-svg-path`:
   * https://github.com/jkroso/parse-svg-path
   */
  commands: (string | number)[][];
}
