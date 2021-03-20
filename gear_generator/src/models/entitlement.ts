export interface Entitlement {
  /** The entitlement's ID  */
  id: string;

  /**
   * A valid Dart expression that evaluates to a
   * static const `Entitlement` value for this entitlement
   * (See all value defined in `lib/models/entitlement.dart`)
   */
  dart: string;
}

/**
 * A mapping of all entitlements. This list should be kept in-sync
 * with `lib/models/entitlements.dart`
 */
export const allEntitlements: { [name: string]: Entitlement } = {
  free: {
    id: 'io.nathanfriend.inspiral.free',
    dart: 'Entitlement.free',
  },
  ovalGears: {
    id: 'io.nathanfriend.inspiral.ovalgears',
    dart: 'Entitlement.ovalgears',
  },
  squareGears: {
    id: 'io.nathanfriend.inspiral.squaregears',
    dart: 'Entitlement.squaregears',
  },
  specialGears: {
    id: 'io.nathanfriend.inspiral.specialgears',
    dart: 'Entitlement.specialgears',
  },
  airbrushPens: {
    id: 'io.nathanfriend.inspiral.airbrushpens',
    dart: 'Entitlement.airbrushpens',
  },
  customPenColors: {
    id: 'io.nathanfriend.inspiral.custompencolors',
    dart: 'Entitlement.custompencolors',
  },
  customBackgroundColors: {
    id: 'io.nathanfriend.inspiral.custombackgroundcolors',
    dart: 'Entitlement.custombackgroundcolors',
  },
};
