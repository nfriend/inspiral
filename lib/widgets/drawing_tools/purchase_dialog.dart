import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:inspiral/state/purchases_state.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:inspiral/models/package.dart' as InspiralPackage;

class PurchaseDialog extends StatefulWidget {
  /// The current PurchasesState object. This must be manually passed since
  /// this dialog doesn't share a `context` with the main app.
  final PurchasesState purchases;

  /// The package being purchased
  final String package;

  /// The function to call if the package is purchased
  final Function onPurchased;

  PurchaseDialog(
      {@required this.purchases,
      @required this.package,
      @required this.onPurchased});

  @override
  _PurchaseDialogState createState() => _PurchaseDialogState();
}

class _PurchaseDialogState extends State<PurchaseDialog> {
  /// Whether or not the dialog should show a modal progress spinner
  bool _isWaitingForPurchase = false;

  Future<Offering> _offeringFuture;

  final ButtonStyle _buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.resolveWith((states) => StadiumBorder()),
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => Colors.green));

  final ButtonStyle _cancelButtonStyle = ButtonStyle(
      shape: MaterialStateProperty.resolveWith((states) => StadiumBorder()),
      foregroundColor:
          MaterialStateProperty.resolveWith((states) => Colors.black87));

  @override
  void initState() {
    super.initState();

    _offeringFuture = _getOffering();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _offeringFuture,
        builder: (BuildContext context, AsyncSnapshot<Offering> snapshot) {
          if (snapshot.hasData) {
            final Offering offering = snapshot.data;

            print(
                "offering.availablePackages: ${offering.availablePackages.map((ap) => ap.identifier).join(', ')}");

            Iterable<Package> allIndividuallyPurchasablePackages =
                offering.availablePackages.where(
                    (p) => p.identifier != InspiralPackage.Package.everything);

            Package everythingPackage =
                offering.getPackage(InspiralPackage.Package.everything);

            Package requestedPackage = offering.getPackage(this.widget.package);

            return Dialog(
                child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text("Unlock", textAlign: TextAlign.center),
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 2.0, bottom: 5.0),
                                  child: Text(requestedPackage.product.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0))),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          text: "for ",
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: requestedPackage
                                                    .product.priceString,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(text: "?")
                                          ]))),
                              ElevatedButton(
                                  style: _buttonStyle,
                                  onPressed: () async {
                                    setState(() {
                                      _isWaitingForPurchase = true;
                                    });
                                    bool productHasBeenPurchased =
                                        await _purchasePackage(
                                            requestedPackage);
                                    setState(() {
                                      _isWaitingForPurchase = false;
                                    });

                                    if (productHasBeenPurchased) {
                                      Navigator.of(context).pop();
                                      widget.onPurchased();
                                    }
                                  },
                                  child: Text(
                                      "Unlock ${requestedPackage.product.title}")),
                              Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                              height: 1,
                                              color: Colors.black26)),
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              5.0, 0.0, 5.0, 2.0),
                                          child: Text(
                                            "or",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          )),
                                      Expanded(
                                          child: Container(
                                              height: 1, color: Colors.black26))
                                    ],
                                  )),
                              Text("Unlock", textAlign: TextAlign.center),
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 2.0, bottom: 5.0),
                                  child: GradientText(
                                    everythingPackage.product.title,
                                    gradient: Gradients.cosmicFusion,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0),
                                  )),
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: "for ",
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: everythingPackage
                                                .product.priceString,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: "?")
                                      ])),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Center(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (Package includedPackage
                                          in allIndividuallyPurchasablePackages)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.check,
                                                color: Colors.green),
                                            Text(includedPackage.product.title)
                                          ],
                                        ),
                                    ],
                                  ))),
                              GradientButton(
                                child: Text(
                                  "Unlock ${everythingPackage.product.title}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                increaseWidthBy: double.infinity,
                                callback: () async {
                                  setState(() {
                                    _isWaitingForPurchase = true;
                                  });
                                  bool productHasBeenPurchased =
                                      await _purchasePackage(everythingPackage);
                                  setState(() {
                                    _isWaitingForPurchase = false;
                                  });

                                  if (productHasBeenPurchased) {
                                    Navigator.of(context).pop();
                                    widget.onPurchased();
                                  }
                                },
                                gradient: Gradients.jShine,
                                elevation: 10.0,
                                shadowColor: Gradients.jShine.colors.last
                                    .withOpacity(0.25),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: OutlinedButton(
                                      style: _cancelButtonStyle,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Cancel",
                                      )))
                            ],
                          )),
                      _isWaitingForPurchase
                          ? Positioned.fill(
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Container(
                                      color: Colors.white,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                              value: null)))))
                          : null
                      // Remove null entries
                    ].where((w) => w != null).toList()));
          } else if (snapshot.hasError) {
            // TODO: error handling here
            return Container();
          } else {
            // TODO: loading state here
            return Container();
          }
        });
  }

  Future<Offering> _getOffering() async {
    Offerings offerings = await Purchases.getOfferings();
    if (offerings.current == null ||
        offerings.current.availablePackages.isEmpty) {
      throw 'Offering returned no packages';
    }

    return offerings.current;
  }

  /// Prompts the user to purchase the provided package using the OS's native
  /// in-app purchasing functionality.
  /// Returns a `bool` that indicates whether or not the product was purchased.
  Future<bool> _purchasePackage(Package packageToBuy) async {
    try {
      await Purchases.purchasePackage(packageToBuy);
      return true;
    } on PlatformException catch (e) {
      PurchasesErrorCode errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        throw e;
      }

      return false;
    }
  }
}
