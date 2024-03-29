import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:inspiral/models/package.dart' as package_model;
import 'package:inspiral/state/color_state.dart';
import 'package:inspiral/state/purchases_state.dart';
import 'package:inspiral/util/prepare_iap_title.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// The content to show when something has _not_
/// gone wrong while processing payments
class PurchaseDialogSuccessContent extends StatefulWidget {
  /// The individual package that should be presented to the user
  final Package requestedPackage;

  /// The "everything" package
  final Package everythingPackage;

  /// All individually purchaseable packages
  final Iterable<Package> allIndividuallyPurchasablePackages;

  /// The handler to call when either "buy" button is pressed
  final Function onPurchaseButtonPressed;

  PurchaseDialogSuccessContent(
      {required this.requestedPackage,
      required this.everythingPackage,
      required this.allIndividuallyPurchasablePackages,
      required this.onPurchaseButtonPressed});

  @override
  _PurchaseDialogSuccessContentState createState() =>
      _PurchaseDialogSuccessContentState();
}

class _PurchaseDialogSuccessContentState
    extends State<PurchaseDialogSuccessContent> {
  /// Whether or not the dialog should show a modal progress spinner
  bool _isWaitingForPurchase = false;

  List<Package> _sortedPackages = [];

  final ButtonStyle _buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.resolveWith((states) => StadiumBorder()),
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => Colors.green));

  @override
  void initState() {
    super.initState();

    // Attempts to sort the list into the ideal order.
    // This is a bit brittle, but it's not a huge deal if things are
    // out of order.
    _sortedPackages = widget.allIndividuallyPurchasablePackages.toList()
      ..sort((p1, p2) {
        return package_model.Package.order.indexOf(p1.identifier) -
            package_model.Package.order.indexOf(p2.identifier);
      });
  }

  @override
  Widget build(BuildContext context) {
    final purchases = Provider.of<PurchasesState>(context, listen: false);
    final colors = Provider.of<ColorState>(context, listen: false);

    final orLineColor = colors.isDark ? Colors.white24 : Colors.black26;

    final _cancelButtonStyle = ButtonStyle(
        shape: MaterialStateProperty.resolveWith((states) => StadiumBorder()),
        foregroundColor: MaterialStateProperty.resolveWith(
            (states) => colors.isDark ? Colors.white70 : Colors.black87));

    return Dialog(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400.0),
            child: SingleChildScrollView(
                child: Stack(alignment: Alignment.center, children: [
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Unlock', textAlign: TextAlign.center),
                      Padding(
                          padding: EdgeInsets.only(top: 2.0, bottom: 5.0),
                          child: Text(
                              prepareIAPTitle(
                                  widget.requestedPackage.product.title),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0))),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'for ',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: widget.requestedPackage.product
                                            .priceString,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: '?')
                                  ]))),
                      ElevatedButton(
                          style: _buttonStyle,
                          onPressed: () async {
                            setState(() {
                              _isWaitingForPurchase = true;
                            });

                            await widget.onPurchaseButtonPressed(
                                purchases, widget.requestedPackage);

                            setState(() {
                              _isWaitingForPurchase = false;
                            });
                          },
                          child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                  'Unlock ${prepareIAPTitle(widget.requestedPackage.product.title)}'))),
                      Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child:
                                      Container(height: 1, color: orLineColor)),
                              Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 2.0),
                                  child: Text(
                                    'or',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  )),
                              Expanded(
                                  child:
                                      Container(height: 1, color: orLineColor))
                            ],
                          )),
                      Text('Unlock', textAlign: TextAlign.center),
                      Padding(
                          padding: EdgeInsets.only(top: 2.0, bottom: 5.0),
                          child: GradientText(
                            prepareIAPTitle(
                                widget.everythingPackage.product.title),
                            gradient: colors.isDark
                                ? Gradients.hotLinear
                                : Gradients.cosmicFusion,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          )),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'for ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget
                                        .everythingPackage.product.priceString,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: '?')
                              ])),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Center(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (Package includedPackage in _sortedPackages)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.check, color: Colors.green),
                                    Text(prepareIAPTitle(
                                        includedPackage.product.title))
                                  ],
                                ),
                            ],
                          ))),
                      GradientButton(
                        increaseWidthBy: double.infinity,
                        callback: () async {
                          setState(() {
                            _isWaitingForPurchase = true;
                          });

                          await widget.onPurchaseButtonPressed(
                              purchases, widget.everythingPackage);

                          setState(() {
                            _isWaitingForPurchase = false;
                          });
                        },
                        gradient: Gradients.jShine,
                        elevation: 10.0,
                        shadowColor:
                            Gradients.jShine.colors.last.withOpacity(0.25),
                        child: Text(
                          'Unlock ${prepareIAPTitle(widget.everythingPackage.product.title)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: OutlinedButton(
                              style: _cancelButtonStyle,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                              )))
                    ],
                  )),
              if (_isWaitingForPurchase)
                Positioned.fill(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                            color: Colors.white,
                            child: Center(
                                child:
                                    CircularProgressIndicator(value: null)))))
            ]))));
  }
}
