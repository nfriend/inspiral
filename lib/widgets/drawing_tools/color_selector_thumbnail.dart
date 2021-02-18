import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
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

    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(children: [
          Positioned.fill(
              child: Container(
                  color: isActive ? colors.accentColor.color : null,
                  child: Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                              color: color.color,
                              width: thumbnailSize,
                              height: thumbnailSize))))),
          Positioned.fill(
              child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: onColorTap,
                  )))
        ]));
  }
}
