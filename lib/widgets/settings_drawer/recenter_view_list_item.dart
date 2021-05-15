import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

class RecenterViewListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final canvas = Provider.of<CanvasState>(context, listen: false);

    return ListTile(
      title: Text('Recenter view'),
      onTap: () {
        canvas.recenterView(context);
        Navigator.of(context).pop();
      },
    );
  }
}
