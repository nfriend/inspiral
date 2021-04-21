import { ContactPoint } from './contact_point';
import { AngleGearHole } from './gear_hole';
import { Entitlement } from './entitlement';
import { Package } from './package';

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
}
