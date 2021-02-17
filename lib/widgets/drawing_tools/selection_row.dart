import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/constants.dart';

class SelectionRow extends StatelessWidget {
  final String label;
  final List<Widget> children;

  SelectionRow({this.label, this.children});

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorState>(context);
    final double padding = 10.0;

    TextStyle textStyle =
        TextStyle(color: colors.uiTextColor.color, fontWeight: FontWeight.bold);

    return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: EdgeInsets.only(right: padding / 2),
              child: Center(
                  child: RotatedBox(
                      quarterTurns: 3, child: Text(label, style: textStyle)))),
          Expanded(
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  itemExtent: thumbnailSize + 10.0,
                  children: children))
        ]);
  }
}
