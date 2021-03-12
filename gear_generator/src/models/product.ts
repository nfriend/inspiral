export interface Product {
  /** The product's ID  */
  id: string;

  /**
   * A valid Dart expression that evaluates to a
   * static const `Product` value for this product
   * (See all value defined in `lib/models/product.dart`)
   */
  dart: string;
}

/**
 * A mapping of all products. This list should be kept in-sync
 * with `lib/models/product.dart`
 */
export const allProducts: { [name: string]: Product } = {
  free: { id: 'io.nathanfriend.inspiral.free', dart: 'Product.free' },
  ovalGears: {
    id: 'io.nathanfriend.inspiral.ovalGears',
    dart: 'Product.ovalGears',
  },
  squareGears: {
    id: 'io.nathanfriend.inspiral.squareGears',
    dart: 'Product.squareGears',
  },
  specialGears: {
    id: 'io.nathanfriend.inspiral.specialGears',
    dart: 'Product.specialGears',
  },
  airbrushPens: {
    id: 'io.nathanfriend.inspiral.airbrushPens',
    dart: 'Product.airbrushPens',
  },
  customPenColors: {
    id: 'io.nathanfriend.inspiral.customPenColors',
    dart: 'Product.customPenColors',
  },
  customBackgroundColors: {
    id: 'io.nathanfriend.inspiral.customBackgroundColors',
    dart: 'Product.customBackgroundColors',
  },
  everything: {
    id: 'io.nathanfriend.inspiral.everything',
    dart: 'Product.everything',
  },
};
