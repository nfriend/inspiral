import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inspiral/state/color_state.dart';
import 'package:inspiral/state/purchases_state.dart';
import 'package:inspiral/widgets/purchases/purchase_dialog_error_content.dart';
import 'package:inspiral/widgets/purchases/purchase_dialog_success_content.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:inspiral/models/package.dart' as inspiral_package;
import 'package:sentry_flutter/sentry_flutter.dart';

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
      {required this.purchases,
      required this.colors,
      required this.package,
      required this.onPurchased});

  @override
  _PurchaseDialogState createState() => _PurchaseDialogState();
}

class _SuccessContentParams {
  final Iterable<Package> allIndividuallyPurchasablePackages;
  final Package everythingPackage;
  final Package requestedPackage;

  _SuccessContentParams(
      {required this.allIndividuallyPurchasablePackages,
      required this.everythingPackage,
      required this.requestedPackage});
}

class _PurchaseDialogState extends State<PurchaseDialog> {
  /// Whether or not to show the error message in the dialog
  bool _showErrorMessage = false;

  late Future<_SuccessContentParams> _successContentFuture;

  @override
  void initState() {
    super.initState();

    _successContentFuture =
        widget.purchases.getCurrentOffering().then((Offering offering) {
      var allIndividuallyPurchasablePackages = offering.availablePackages
          .where((p) => p.identifier != inspiral_package.Package.everything);

      if (allIndividuallyPurchasablePackages.isEmpty) {
        throw 'no available packages were found';
      }

      var everythingPackage =
          offering.getPackage(inspiral_package.Package.everything);

      if (everythingPackage == null) {
        throw 'the ${inspiral_package.Package.everything} package was not found';
      }

      var requestedPackage = offering.getPackage(widget.package);

      if (requestedPackage == null) {
        throw 'the $requestedPackage package was not found';
      }

      return _SuccessContentParams(
          allIndividuallyPurchasablePackages:
              allIndividuallyPurchasablePackages,
          everythingPackage: everythingPackage,
          requestedPackage: requestedPackage);
    }).catchError((Object error, StackTrace stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      throw error;
    });
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
          future: _successContentFuture,
          builder: (BuildContext context,
              AsyncSnapshot<_SuccessContentParams> snapshot) {
            if (snapshot.hasData) {
              return PurchaseDialogSuccessContent(
                requestedPackage: snapshot.data!.requestedPackage,
                everythingPackage: snapshot.data!.everythingPackage,
                allIndividuallyPurchasablePackages:
                    snapshot.data!.allIndividuallyPurchasablePackages,
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
    } catch (err, stackTrace) {
      setState(() {
        _showErrorMessage = true;
      });

      await Sentry.captureException(err, stackTrace: stackTrace);
    }

    if (productHasBeenPurchased) {
      Navigator.of(context).pop();
      widget.onPurchased();
    }
  }
}
