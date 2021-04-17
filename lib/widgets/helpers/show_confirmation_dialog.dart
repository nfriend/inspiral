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
  if (message == null && messageWidget == null) {
    throw 'either the message or content parameter must be non-null';
  } else if (message != null && messageWidget != null) {
    throw 'only the message OR the content must be provided - not both';
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
              child: message != null ? Text(message) : messageWidget),
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
