import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';
import 'package:tinycolor/tinycolor.dart';

class NoColorThumbnail extends StatelessWidget {
  final bool isActive;
  final Function onColorTap;

  NoColorThumbnail({@required this.isActive, @required this.onColorTap});

  @override
  Widget build(BuildContext context) {
    final TinyColor activeColor =
        context.select<ColorState, TinyColor>((colors) => colors.activeColor);
    final TinyColor buttonColor =
        context.select<ColorState, TinyColor>((colors) => colors.buttonColor);
    final BorderRadius outerBorderRadius =
        BorderRadius.all(Radius.circular(10.0));
    final BorderRadius innerBorderRadius =
        BorderRadius.all(Radius.circular(5.0));

    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 5.0,
              color: isActive ? activeColor.color : Colors.transparent,
            ),
            borderRadius: outerBorderRadius),
        child: Center(
          child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Material(
                  color: buttonColor.color,
                  borderRadius: innerBorderRadius,
                  child: InkWell(
                    borderRadius: innerBorderRadius,
                    onTap: onColorTap,
                    child:
                        Center(child: Icon(Icons.not_interested, size: 40.0)),
                  ))),
        ));
  }
}
