import 'dart:async';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';

/// Prompts the user to purchase the provided product using the OS's native
/// in-app purchasing functionality.
/// Returns a `bool` that indicates whether or not the product was purchased.
Future<bool> purchaseProduct(PurchasesState purchases, Product product) async {
  await FlutterInappPurchase.instance.initConnection;

  Completer<bool> completer = Completer<bool>();

  StreamSubscription<PurchasedItem> purchaseUpdatedSubscription =
      FlutterInappPurchase.purchaseUpdated.listen((productItem) {
    print('purchase-updated: $productItem');
    // The user purchased the product
    completer.complete(true);
  });

  StreamSubscription<PurchaseResult> purchaseErrorSubscription =
      FlutterInappPurchase.purchaseError.listen((purchaseError) {
    print('purchase-error: $purchaseError');

    if (purchaseError.code == "E_USER_CANCELLED") {
      // The user did not purchase the product, so return `false`
      completer.complete(false);
    } else {
      // The user attempted to purchase the product, but something went
      // wrong. Throw an error.
      completer.completeError(purchaseError);
    }
  });

  await FlutterInappPurchase.instance.getProducts([product.id]);

  // We don't await this one, because updates to the purchases status are
  // reported through the `purchaseUpdated` and `purchaseError` streams above
  FlutterInappPurchase.instance.requestPurchase(product.id);

  bool productHasBeenPurchased = await completer.future;

  purchaseUpdatedSubscription.cancel();
  purchaseErrorSubscription.cancel();

  await FlutterInappPurchase.instance.endConnection;

  if (productHasBeenPurchased) {
    await purchases.updatePurchasedItems();
  }

  return productHasBeenPurchased;
}
