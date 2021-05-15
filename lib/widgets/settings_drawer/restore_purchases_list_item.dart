import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

class RestorePurchasesListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final purchases = Provider.of<PurchasesState>(context, listen: false);
    final progress = Provider.of<ProgressState>(context, listen: false);

    return ListTile(
      title: Text('Restore purchases'),
      onTap: () async {
        Navigator.of(context).pop();
        progress.showModalProgress(message: 'Restoring purchases...');
        await purchases.restorePurchases();
        progress.hideModalPropress();
      },
    );
  }
}
