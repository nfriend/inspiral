import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inspiral/state/color_state.dart';
import 'package:inspiral/state/purchases_state.dart';
import 'package:inspiral/widgets/purchases/purchase_dialog_error_content.dart';
import 'package:inspiral/widgets/purchases/purchase_dialog_success_content.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:inspiral/models/package.dart' as inspiral_package;

class PurchaseDialog extends StatefulWidget {
  /// The current PurchasesState object. This must be manually passed since
  /// this dialog doesn't share a `context` with the main app.
  final PurchasesState purchases;

  /// The current ColorState object. Same note as above.
  final ColorState colors;

  /// The package being purchased
  final String package;

  /// The function to call if the package is purchased
  final Function onPurchased;

  PurchaseDialog(
      {@required this.purchases,
      @required this.colors,
      @required this.package,
      @required this.onPurchased});

  @override
  _PurchaseDialogState createState() => _PurchaseDialogState();
}

class _PurchaseDialogState extends State<PurchaseDialog> {
  /// Whether or not to show the error message in the dialog
  bool _showErrorMessage = false;

  Future<Offering> _offeringFuture;

  @override
  void initState() {
    super.initState();

    _offeringFuture = widget.purchases.getCurrentOffering();
  }

  @override
  Widget build(BuildContext context) {
    Widget errorContent = PurchaseDialogErrorContent();

    if (_showErrorMessage) {
      return errorContent;
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: widget.purchases),
        ChangeNotifierProvider.value(value: widget.colors)
      ],
      child: FutureBuilder(
          future: _offeringFuture,
          builder: (BuildContext context, AsyncSnapshot<Offering> snapshot) {
            if (snapshot.hasData) {
              final offering = snapshot.data;

              var allIndividuallyPurchasablePackages =
                  offering.availablePackages.where((p) =>
                      p.identifier != inspiral_package.Package.everything);

              var everythingPackage =
                  offering.getPackage(inspiral_package.Package.everything);

              var requestedPackage = offering.getPackage(widget.package);

              return PurchaseDialogSuccessContent(
                requestedPackage: requestedPackage,
                everythingPackage: everythingPackage,
                allIndividuallyPurchasablePackages:
                    allIndividuallyPurchasablePackages,
                onPurchaseButtonPressed: _purchaseButtonPressed,
              );
            } else if (snapshot.hasError) {
              return errorContent;
            } else {
              // Loading state. By the time this dialog is shown, the results
              // being loaded are cached, so there is virtually no delay. As a
              // result, we don't need a visual loading state.
              return Container();
            }
          }),
    );
  }

  /// Handles both the individual product button and the "everything" button
  Future<void> _purchaseButtonPressed(
      PurchasesState purchases, Package packageToBuy) async {
    var productHasBeenPurchased = false;
    try {
      productHasBeenPurchased = await purchases.purchasePackage(packageToBuy);
    } catch (error) {
      setState(() {
        _showErrorMessage = true;
      });
    }

    if (productHasBeenPurchased) {
      Navigator.of(context).pop();
      widget.onPurchased();
    }
  }
}
