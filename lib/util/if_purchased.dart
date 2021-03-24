import 'package:flutter/material.dart';
import 'package:inspiral/state/purchases_state.dart';
import 'package:inspiral/widgets/purchases/purchase_dialog.dart';
import 'package:provider/provider.dart';

/// Returns a function that executes the callback if the provided entitlement is
/// owned. If the entitlement is not purchased, the purchase dialog is shown
/// for the provide package and the callback is not executed.
Function ifPurchased(
    {BuildContext context,
    String entitlement,
    String package,
    Function callbackIfPurchased}) {
  final purchases = Provider.of<PurchasesState>(context, listen: false);

  return () async {
    if (!await purchases.isEntitledTo(entitlement)) {
      showDialog(
          context: context,
          builder: (context) {
            return PurchaseDialog(
                purchases: purchases,
                package: package,
                onPurchased: callbackIfPurchased);
          });
    } else {
      return callbackIfPurchased();
    }
  };
}
