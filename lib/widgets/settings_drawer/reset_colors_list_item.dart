import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/helpers/show_confirmation_dialog.dart';
import 'package:provider/provider.dart';

class ResetColorsListItem extends StatefulWidget {
  @override
  _ResetColorsListItemState createState() => _ResetColorsListItemState();
}

class _ResetColorsListItemState extends State<ResetColorsListItem> {
  Future<bool> _entitlementCheckFuture;

  @override
  void initState() {
    // Determine if the user has access to custom pen colors _or_
    // custom canvas colors. If they do, show the "Reset colors"
    // option (it doesn't make sense to show this if they can't
    // modify the list of colors).
    var purchases = Provider.of<PurchasesState>(context, listen: false);
    _entitlementCheckFuture = Future.wait([
      purchases.isEntitledTo(Entitlement.custompencolors),
      purchases.isEntitledTo(Entitlement.custombackgroundcolors)
    ]).then((values) => values.any((b) => b));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorState>(context, listen: false);

    return FutureBuilder(
        future: _entitlementCheckFuture,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            return ListTile(
                title: Text('Reset pen and canvas colors'),
                onTap: () {
                  showConfirmationDialog(
                      context: context,
                      message:
                          'Are you sure you want to reset your canvas and pen colors back to their defaults?',
                      confirmButtonText: 'Reset',
                      onConfirm: () {
                        Navigator.of(context).pop();
                        colors.reset();
                      });
                });
          } else {
            return Container();
          }
        });
  }
}
