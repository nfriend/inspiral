import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class ColorSelectorThumbnail extends StatelessWidget {
  final TinyColor color;
  final bool isActive;
  final Function onColorTap;

  ColorSelectorThumbnail(
      {@required this.color,
      @required this.isActive,
      @required this.onColorTap});

  @override
  Widget build(BuildContext context) {
    var colors = Provider.of<ColorState>(context);

    return Stack(children: [
      Positioned.fill(
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5.0,
                  color:
                      isActive ? colors.activeColor.color : Colors.transparent,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Container(
                    decoration: BoxDecoration(
                  color: color.color,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                )),
              )))),
      Positioned.fill(
          child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onColorTap,
              )))
    ]);
  }
}
