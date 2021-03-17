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
  free: {
    id: 'io.nathanfriend.inspiral.development.free',
    dart: 'Product.free',
  },
  ovalGears: {
    id: 'io.nathanfriend.inspiral.development.ovalgears',
    dart: 'Product.ovalGears',
  },
  squareGears: {
    id: 'io.nathanfriend.inspiral.development.squaregears',
    dart: 'Product.squareGears',
  },
  specialGears: {
    id: 'io.nathanfriend.inspiral.development.specialgears',
    dart: 'Product.specialGears',
  },
  airbrushPens: {
    id: 'io.nathanfriend.inspiral.development.airbrushpens',
    dart: 'Product.airbrushPens',
  },
  customPenColors: {
    id: 'io.nathanfriend.inspiral.development.custompencolors',
    dart: 'Product.customPenColors',
  },
  customBackgroundColors: {
    id: 'io.nathanfriend.inspiral.development.custombackgroundcolors',
    dart: 'Product.customBackgroundColors',
  },
  everything: {
    id: 'io.nathanfriend.inspiral.development.everything',
    dart: 'Product.everything',
  },
};
