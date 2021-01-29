import { ContactPoint } from './contact_point';
import { AngleGearHole } from './gear_hole';

/**
 * A class that holds all the data necessary to
 * instantiate a Dart `GearDefinition` class
 * (lib/models/gear_definition.dart).
 */
export interface GearDefinition {
  /** The name of this gear */
  gearName: string;

  /** The asset path to the gear's image */
  image: string;

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
}
