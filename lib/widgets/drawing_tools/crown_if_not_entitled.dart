import 'package:flutter/material.dart';
import 'package:inspiral/state/purchases_state.dart';
import 'package:provider/provider.dart';

class CrownIfNotEntitled extends StatelessWidget {
  final String entitlement;

  CrownIfNotEntitled({@required this.entitlement});

  @override
  Widget build(BuildContext context) {
    final purchases = Provider.of<PurchasesState>(context);

    Widget crown =
        Positioned(top: 0, right: 0, child: Image.asset("images/crown2.png"));

    return FutureBuilder(
        future: purchases.isEntitledTo(entitlement),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data ? Container() : crown;
          } else if (snapshot.hasError) {
            // TODO: Handle this case
            return crown;
          } else {
            // TODO: Handle this case
            return crown;
          }
        });
  }
}
