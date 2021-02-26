export interface ProductId {
  /** The actual product ID  */
  id: string;

  /**
   * A valid Dart expression that evaluates to a
   * `ProductId` enum value for this product ID
   */
  dart: string;
}

/**
 * A mapping of all product IDs. This list should be kept in-sync
 * with `lib/models/product_id.dart`
 */
export const allProductIds: { [name: string]: ProductId } = {
  free: { id: 'io.nathanfriend.inspiral.free', dart: 'ProductId.free' },
  ovalGears: {
    id: 'io.nathanfriend.inspiral.ovalGears',
    dart: 'ProductId.ovalGears',
  },
  squareGears: {
    id: 'io.nathanfriend.inspiral.squareGears',
    dart: 'ProductId.squareGears',
  },
  specialGears: {
    id: 'io.nathanfriend.inspiral.specialGears',
    dart: 'ProductId.specialGears',
  },
  airbrushPens: {
    id: 'io.nathanfriend.inspiral.airbrushPens',
    dart: 'ProductId.airbrushPens',
  },
};
