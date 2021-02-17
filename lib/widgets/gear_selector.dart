import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/models/gears/gears.dart';

class GearSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorState>(context);
    final double padding = 10.0;

    TextStyle textStyle =
        TextStyle(color: colors.uiTextColor.color, fontWeight: FontWeight.bold);

    Row rowOfGears = Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: EdgeInsets.only(right: padding / 2),
              child: Center(
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Text("ROTATING", style: textStyle)))),
          Expanded(
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  itemExtent: thumbnailSize,
                  children: [
                for (var gear in allGears.values)
                  Image.asset(gear.thumbnailImage)
              ]))
        ]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: Padding(
                padding:
                    EdgeInsets.fromLTRB(padding, padding, padding, padding / 2),
                child: rowOfGears)),
        Expanded(
            child: Padding(
                padding:
                    EdgeInsets.fromLTRB(padding, padding / 2, padding, padding),
                child: rowOfGears))
      ],
    );
  }
}
