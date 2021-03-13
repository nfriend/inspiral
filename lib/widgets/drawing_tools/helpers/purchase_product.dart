import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:inspiral/models/models.dart';

Future<void> purchaseProduct(Product product) async {
  final bool available = await InAppPurchaseConnection.instance.isAvailable();
  if (!available) {
    // TODO
    print("The store isn't available!");
    return;
  }

  print("The store is available!");

  Set<String> allBuyableIds =
      Product.allIndividuallyBuyableProducts.map((p) => p.id).toSet();
  final ProductDetailsResponse response =
      await InAppPurchaseConnection.instance.queryProductDetails(allBuyableIds);
  if (response.notFoundIDs.isNotEmpty) {
    // TODO
    // Handle the error.
    print("uh oh!");
  }
  List<ProductDetails> products = response.productDetails;

  print("All Product IDs: ${products.map((e) => e.id).join(', ')}");

  final ProductDetails productToBuy =
      products.firstWhere((element) => element.id == product.id);
  final PurchaseParam purchaseParam =
      PurchaseParam(productDetails: productToBuy);
  InAppPurchaseConnection.instance
      .buyNonConsumable(purchaseParam: purchaseParam);
}
