import 'package:flutter/material.dart';

class ToggleListItem extends StatelessWidget {
  final String text;
  final bool value;
  final Function(bool) onChanged;

  ToggleListItem(
      {@required this.text, @required this.value, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              child: Text(text, style: TextStyle(fontWeight: FontWeight.w500))),
          Switch(value: value, onChanged: onChanged)
        ]));
  }
}
