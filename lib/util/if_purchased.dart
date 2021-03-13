import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/purchases_state.dart';
import 'package:inspiral/widgets/drawing_tools/purchase_dialog.dart';
import 'package:provider/provider.dart';

/// Returns a function that executes the callback if the provided product is
/// purchased. If the product is not purchased, the purchase dialog is shown
/// and the callback is not executed.
Function ifPurchased(
    BuildContext context, Product product, Function callbackIfPurchased) {
  final purchases = Provider.of<PurchasesState>(context, listen: false);

  return () {
    if (!purchases.purchased(product)) {
      showDialog(
          context: context,
          builder: (context) {
            return PurchaseDialog(
                product: product, onPurchased: callbackIfPurchased);
          });
    } else {
      return callbackIfPurchased();
    }
  };
}
