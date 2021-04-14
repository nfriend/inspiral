import 'package:flutter/material.dart';

var _buttonStyle = ButtonStyle(
  backgroundColor:
      MaterialStateProperty.resolveWith((states) => Colors.transparent),
);

/// Shows a confirm/cancel modal dialog with a custom messag
void showConfirmationDialog(
    {@required BuildContext context,
    @required String message,
    @required void Function() onConfirm,
    String confirmButtonText = 'yes'}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(child: Text(message)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: _buttonStyle,
              child: Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              style: _buttonStyle,
              child: Text(confirmButtonText.toUpperCase()),
            ),
          ],
        );
      });
}
