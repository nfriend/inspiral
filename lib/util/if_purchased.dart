import 'package:flutter/material.dart';
import 'package:inspiral/state/color_state.dart';
import 'package:inspiral/state/purchases_state.dart';
import 'package:inspiral/widgets/purchases/purchase_dialog.dart';
import 'package:provider/provider.dart';

/// Returns a function that executes the callback if the provided entitlement is
/// owned. If the entitlement is not purchased, the purchase dialog is shown
/// for the provide package and the callback is not executed.
Future<void> Function() ifPurchased(
    {required BuildContext context,
    required String entitlement,
    String? package,
    required void Function() callbackIfPurchased}) {
  final purchases = Provider.of<PurchasesState>(context, listen: false);
  final colors = Provider.of<ColorState>(context, listen: false);

  return () async {
    if (!await purchases.isEntitledTo(entitlement)) {
      assert(package != null,
          'Package must not be null if entitlement is not Entitlement.free. The provided entitlement was: $entitlement');

      await showDialog(
          context: context,
          builder: (context) {
            return PurchaseDialog(
                purchases: purchases,
                colors: colors,
                package: package!,
                onPurchased: callbackIfPurchased);
          });
    } else {
      return callbackIfPurchased();
    }
  };
}
