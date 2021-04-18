import 'package:flutter/material.dart';

var _buttonStyle = ButtonStyle(
  backgroundColor:
      MaterialStateProperty.resolveWith((states) => Colors.transparent),
);

/// Shows a confirm/cancel modal dialog with a custom message
void showConfirmationDialog(
    {@required BuildContext context,
    String message,
    Widget messageWidget,
    @required void Function() onConfirm,
    String confirmButtonText = 'yes'}) {
  assert((message == null) ^ (messageWidget == null),
      'Exactly one of the `message` and `messageWidget` parameters must be non-null');

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(child: messageWidget ?? Text(message)),
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
