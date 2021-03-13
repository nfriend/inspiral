import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

/// A widget that listens for updates to in-app purchases
/// and updates the `PurchasesState` accordingly
class PurchasesListener extends StatefulWidget {
  final Widget child;

  PurchasesListener({@required this.child});

  @override
  _PurchasesListenerState createState() => _PurchasesListenerState();
}

class _PurchasesListenerState extends State<PurchasesListener> {
  StreamSubscription<List<PurchaseDetails>> _subscription;

  @override
  void initState() {
    final purchases = Provider.of<PurchasesState>(context, listen: false);

    final Stream<List<PurchaseDetails>> purchaseUpdates =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdates.listen((updates) {
      purchases.updatePurchases(updates);
    });

    InAppPurchaseConnection.instance
        .queryPastPurchases()
        .then((QueryPurchaseDetailsResponse response) {
      if (response.error != null) {
        // TODO: How should this error be handled?
        return;
      }

      purchases.updatePurchases(response.pastPurchases);

      if (Platform.isIOS) {
        response.pastPurchases.forEach((pastPurchase) {
          // Mark that you've delivered the purchase. Only the App Store requires
          // this final confirmation.
          InAppPurchaseConnection.instance.completePurchase(pastPurchase);
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
