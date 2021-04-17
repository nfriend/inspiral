import 'package:flutter/material.dart';
import 'package:inspiral/models/canvas_size.dart';

class CanvasSizeListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              child: Text('Canvas size',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          DropdownButton(
            value: CanvasSize.large,
            items: CanvasSize.all.map<DropdownMenuItem>((size) {
              return DropdownMenuItem<CanvasSizeAndName>(
                  value: size, child: Text(size.name));
            }).toList(),
            onChanged: (newValue) {
              // TODO: update canvas size here
              print('newValue: ${newValue.name}');
            },
          )
        ]));
  }
}
