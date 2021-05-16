import { ContactPoint } from './contact_point';
import { AngleGearHole } from './gear_hole';
import { Entitlement } from './entitlement';
import { Package } from './package';
import { Point } from './point';

/**
 * A class that holds all the data necessary to
 * instantiate a Dart `GearDefinition` class
 * (lib/models/gear_definition.dart).
 */
export interface GearDefinition {
  /** The name of this gear */
  gearName: string;

  /** The name of this gear in camelCased format */
  camelCasedGearName: string;

  /** The asset path to the gear's image */
  image: string;

  /** The asset path to the gear's thumbnail image */
  thumbnailImage: string;

  /** The size of the gear, in logical pixels */
  size: {
    width: number;
    height: number;
  };

  /** The center point of this gear, in logical pixels */
  center: Point;

  /** The number of teeth on this gear */
  toothCount: number;

  /** The points that define the shape of this gear */
  points: ContactPoint[];

  /** The holes in the gear */
  holes: AngleGearHole[];

  /** The entitlement of this gear. */
  entitlement: Entitlement;

  /** The package that will unlock the gear's entitlement */
  package: Package;

  /** The order of this gear, relative to all other gears */
  gearOrder: number;

  /**
   * Whether or not this gear is a ring gear (i.e. its teeth
   * appear on the inside of the gear.)
   */
  isRing: boolean;

  /** Whether or not this gear is perfectly round */
  isRound: boolean;

  /**
   * If this gear is a ring gear, this indicates how much of a
   * border radius should be rendered on its outside border.
   */
  ringBorderRadius: number;

  /**
   * The smallest angle difference in a convex direction between
   * any two consecutive teeth on this gear.
   */
  smallestConvexDiff: number;

  /**
   * The biggest angle difference in a convex direction between
   * any two consecutive teeth on this gear.
   */
  biggestConvexDiff: number;

  /**
   * The smallest angle difference in a concave direction between
   * any two consecutive teeth on this gear.
   */
  smallestConcaveDiff: number;

  /**
   * The biggest angle difference in a concave direction between
   * any two consecutive teeth on this gear.
   */
  biggestConcaveDiff: number;
}
