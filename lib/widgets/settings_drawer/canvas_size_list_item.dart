import 'package:flutter/material.dart';
import 'package:inspiral/models/canvas_size.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/helpers/show_confirmation_dialog.dart';
import 'package:inspiral/widgets/settings_drawer/list_item_padding.dart';
import 'package:provider/provider.dart';

class CanvasSizeListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var canvas = Provider.of<CanvasState>(context, listen: false);
    var canvasSizeAndName = context.select<CanvasState, CanvasSizeAndName>(
        (canvas) => canvas.canvasSizeAndName);

    return ListItemPadding(
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(
          child: Text('Canvas size',
              style: TextStyle(fontWeight: FontWeight.w500))),
      DropdownButton<CanvasSizeAndName>(
        value: canvasSizeAndName,
        items: CanvasSize.all.map<DropdownMenuItem<CanvasSizeAndName>>((size) {
          return DropdownMenuItem<CanvasSizeAndName>(
              value: size, child: Text(size.name));
        }).toList(),
        onChanged: (newSize) {
          // Do nothing if the user selected the already-selected size
          if (newSize == canvasSizeAndName) {
            return;
          }

          showConfirmationDialog(
              context: context,
              messageWidget: Column(
                children: [
                  Text(
                      'Changing the canvas size will erase your current masterpiece.'),
                  Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text('Are you sure you want to continue?',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  newSize != CanvasSize.small
                      ? Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                              'Note: slower devices may be sluggish with medium or large canvases.',
                              style: TextStyle(fontStyle: FontStyle.italic)))
                      : Container()
                ],
              ),
              onConfirm: () {
                Navigator.of(context).pop();
                canvas.setCanvasSize(context: context, newSize: newSize);
              });
        },
      )
    ]));
  }
}
