import 'package:flutter/material.dart';
import 'package:inspiral/widgets/settings_drawer/list_item_padding.dart';

class DropdownListItem extends StatelessWidget {
  final String text;
  final String selectedItem;
  final List<String> items;
  final Function(String) onChanged;

  DropdownListItem(
      {@required this.text,
      @required this.selectedItem,
      @required this.items,
      @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListItemPadding(
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(
          child: Text(text, style: TextStyle(fontWeight: FontWeight.w500))),
      DropdownButton(
          value: selectedItem,
          items: items
              .map((item) =>
                  DropdownMenuItem<String>(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged)
    ]));
  }
}
