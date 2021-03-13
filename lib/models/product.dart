import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

@immutable
class Product {
  /// The ID of this product
  final String id;

  /// The human-readable name of this product
  final String name;

  /// The price of this product, in USD cents
  final int price;

  /// The price for display purposes
  String get displayPrice {
    if (price < 100) {
      return "$price¢";
    } else {
      return "\$${price / 100.0}";
    }
  }

  const Product({this.id, this.name, this.price});

  @override
  String toString() {
    return "Product(id: $id, name: $name, price: $price)";
  }

  @override
  int get hashCode => hash3(id.hashCode, name.hashCode, price.hashCode);

  @override
  bool operator ==(Object other) =>
      other is Product &&
      other.id == id &&
      other.name == name &&
      other.price == price;

  /// A list of all available products. This list should be kept in-sync
  /// with `gear_generator/src/models/product_id.ts`
  static const Product free =
      Product(id: "io.nathanfriend.inspiral.free", name: "Free", price: 0);
  static const Product ovalGears = Product(
      id: "io.nathanfriend.inspiral.ovalgears", name: "Oval Gears", price: 99);
  static const Product squareGears = Product(
      id: "io.nathanfriend.inspiral.squaregears",
      name: "Square Gears",
      price: 99);
  static const Product specialGears = Product(
      id: "io.nathanfriend.inspiral.specialgears",
      name: "Special Gears",
      price: 99);
  static const Product airbrushPens = Product(
      id: "io.nathanfriend.inspiral.airbrushpens",
      name: "Airbrush Pens",
      price: 99);
  static const Product customPenColors = Product(
      id: "io.nathanfriend.inspiral.custompencolors",
      name: "Custom Pen Colors",
      price: 99);
  static const Product customBackgroundColors = Product(
      id: "io.nathanfriend.inspiral.custombackgroundcolors",
      name: "Custom Background Colors",
      price: 99);
  static const Product everything = Product(
      id: "io.nathanfriend.inspiral.everything",
      name: "Everything",
      price: 499);

  static const List<Product> allIndividuallyBuyableProducts = [
    Product.customBackgroundColors,
    Product.customPenColors,
    Product.ovalGears,
    Product.squareGears,
    Product.specialGears,
    Product.airbrushPens,
  ];
}
