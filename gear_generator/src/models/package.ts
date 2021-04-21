export interface Package {
  /** The package's id */
  id: string;

  /**
   * A valid Dart expression that evaluates to a
   * static const `Package` value for this package
   * (See all value defined in `lib/models/package.dart`)
   */
  dart: string;
}

/**
 * A mapping of all packages. This list should be kept in-sync
 * with `lib/models/packages.dart`
 */
export const allPackages: { [name: string]: Package } = {
  free: {
    id: 'io.nathanfriend.inspiral.free',
    dart: 'Package.free',
  },
  ovalGears: {
    id: 'io.nathanfriend.inspiral.ovalgears',
    dart: 'Package.ovalgears',
  },
  triangleGears: {
    id: 'io.nathanfriend.inspiral.trianglegears',
    dart: 'Package.trianglegears',
  },
  squareGears: {
    id: 'io.nathanfriend.inspiral.squaregears',
    dart: 'Package.squaregears',
  },
  pentagonGears: {
    id: 'io.nathanfriend.inspiral.pentagongears',
    dart: 'Package.pentagongears',
  },
  specialGears: {
    id: 'io.nathanfriend.inspiral.specialgears',
    dart: 'Package.specialgears',
  },
  airbrushPens: {
    id: 'io.nathanfriend.inspiral.airbrushpens',
    dart: 'Package.airbrushpens',
  },
  customPenColors: {
    id: 'io.nathanfriend.inspiral.custompencolors',
    dart: 'Package.custompencolors',
  },
  customBackgroundColors: {
    id: 'io.nathanfriend.inspiral.custombackgroundcolors',
    dart: 'Package.custombackgroundcolors',
  },
  everything: {
    id: 'io.nathanfriend.inspiral.everything',
    dart: 'Package.everything',
  },
};
