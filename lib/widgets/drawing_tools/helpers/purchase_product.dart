import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:inspiral/models/models.dart';

/// Prompts the user to purchase the provided product using the OS's native
/// in-app purchasing functionality.
/// Returns a `bool` that indicates whether or not the product was purchased.
Future<bool> purchaseProduct(Product product) async {
  final bool available = await InAppPurchaseConnection.instance.isAvailable();
  if (!available) {
    throw ("unable to connect to the store!");
  }

  final ProductDetailsResponse response = await InAppPurchaseConnection.instance
      .queryProductDetails([product.id].toSet());
  if (response.notFoundIDs.isNotEmpty) {
    throw ("unable find product '${product.id}' in the store!");
  }

  final ProductDetails productToBuy =
      response.productDetails.firstWhere((element) => element.id == product.id);
  final PurchaseParam purchaseParam =
      PurchaseParam(productDetails: productToBuy);
  await InAppPurchaseConnection.instance
      .buyNonConsumable(purchaseParam: purchaseParam);

  Completer<bool> completer = Completer<bool>();

  final Stream<List<PurchaseDetails>> purchaseUpdates =
      InAppPurchaseConnection.instance.purchaseUpdatedStream;
  StreamSubscription<List<PurchaseDetails>> subscription =
      purchaseUpdates.listen((updates) {
    PurchaseDetails purchasedProduct = updates.firstWhere(
        (details) => details.productID == product.id,
        orElse: () => null);

    if (purchasedProduct == null) {
      // The user did not purchase the product, so return `false`
      completer.complete(false);
    } else if (purchasedProduct.status == PurchaseStatus.error) {
      // The user attempted to purchase the product, but something went
      // wrong. Throw an error.
      completer.completeError(purchasedProduct.error);
    } else if (purchasedProduct.status == PurchaseStatus.purchased) {
      // The user purchased the product
      completer.complete(true);
    } else {
      // We got an update, but it didn't include any details about the
      // product we just purchased.
      // Keep waiting for an update about the purchase.
    }
  });

  bool productHasBeenPurchased = await completer.future;

  subscription.cancel();

  return productHasBeenPurchased;
}
