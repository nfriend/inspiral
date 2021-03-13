import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:inspiral/models/models.dart';

class PurchasesState extends ChangeNotifier {
  static PurchasesState _instance;

  factory PurchasesState.init({@required List<Product> initialPurchases}) {
    return _instance =
        PurchasesState._internal(initialPurchases: initialPurchases);
  }

  factory PurchasesState() {
    assert(_instance != null,
        'The PurchasesState.init() factory constructor must be called before using the PurchasesState() constructor.');
    return _instance;
  }

  PurchasesState._internal({@required List<Product> initialPurchases}) {
    _purchases = initialPurchases;
    _unmodifiablePurchases = UnmodifiableListView(_purchases);
  }

  List<Product> _purchases;
  UnmodifiableListView<Product> _unmodifiablePurchases;
  List<Product> get purchases => _unmodifiablePurchases;

  /// Updates this state's list of `purchases` based on the provided
  /// list of `PurchaseDetails`
  void updatePurchases(List<PurchaseDetails> purchaseDetails) {
    List<Product> newPurchases = [Product.free];
    purchaseDetails
        .where((purchaseDetail) =>
            purchaseDetail.status == PurchaseStatus.purchased)
        .forEach((purchaseDetail) {
      Product purchasedProduct = Product.allIndividuallyBuyableProducts
          .firstWhere((p) => p.id == purchaseDetail.productID,
              orElse: () => null);

      if (purchasedProduct != null) {
        newPurchases.add(purchasedProduct);
      }
    });

    _purchases = newPurchases;
    notifyListeners();
  }

  /// Returns a boolean indicating whether or not
  /// the provided `Product` has been purchased
  bool purchased(Product product) {
    if (_purchases.contains(Product.everything)) {
      return true;
    }

    return _purchases.contains(product);
  }
}
