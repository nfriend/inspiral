import 'package:flutter/material.dart';

/// The content to show when something goes wrong while processing payments
class PurchaseDialogErrorContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Something went wrong!"),
      content: Text("Please try again."),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(), child: Text("CLOSE"))
      ],
    );
  }
}
