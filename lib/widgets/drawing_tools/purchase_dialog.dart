import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

@immutable
class PurchaseDialog extends StatelessWidget {
  /// The product being purchased
  final Product product;

  PurchaseDialog({@required this.product});

  final ButtonStyle buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.resolveWith((states) => StadiumBorder()),
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => Colors.green));

  final ButtonStyle cancelButtonStyle = ButtonStyle(
      shape: MaterialStateProperty.resolveWith((states) => StadiumBorder()),
      foregroundColor:
          MaterialStateProperty.resolveWith((states) => Colors.black87));

  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Unlock", textAlign: TextAlign.center),
                Padding(
                    padding: EdgeInsets.only(top: 2.0, bottom: 5.0),
                    child: Text(product.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0))),
                Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "for ",
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: product.displayPrice,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: "?")
                            ]))),
                ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {},
                    child: Text("Unlock ${product.name}")),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(height: 1, color: Colors.black26)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 2.0),
                            child: Text(
                              "or",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )),
                        Expanded(
                            child: Container(height: 1, color: Colors.black26))
                      ],
                    )),
                Text("Unlock", textAlign: TextAlign.center),
                Padding(
                    padding: EdgeInsets.only(top: 2.0, bottom: 5.0),
                    child: GradientText(
                      Product.everything.name,
                      gradient: Gradients.cosmicFusion,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    )),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "for ",
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: Product.everything.displayPrice,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: "?")
                        ])),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (Product includedProduct
                            in Product.allIndividuallyBuyableProducts)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check, color: Colors.green),
                              Text(includedProduct.name)
                            ],
                          ),
                      ],
                    ))),
                GradientButton(
                  child: Text(
                    "Unlock ${Product.everything.name}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  increaseWidthBy: double.infinity,
                  callback: () {},
                  gradient: Gradients.jShine,
                  elevation: 10.0,
                  shadowColor: Gradients.jShine.colors.last.withOpacity(0.25),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: OutlinedButton(
                        style: cancelButtonStyle,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                        )))
              ],
            )));
  }
}
