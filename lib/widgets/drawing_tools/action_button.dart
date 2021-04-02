import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltipMessage;
  final Function onButtonTap;

  ActionButton(
      {@required this.icon,
      @required this.tooltipMessage,
      @required this.onButtonTap});

  @override
  Widget build(BuildContext context) {
    final ColorState colors = Provider.of<ColorState>(context, listen: false);
    final TinyColor buttonColor =
        context.select<ColorState, TinyColor>((colors) => colors.buttonColor);
    final TinyColor uiTextColor =
        context.select<ColorState, TinyColor>((colors) => colors.uiTextColor);
    final BorderRadius borderRadius = BorderRadius.all(Radius.circular(5.0));

    return Padding(
        padding: EdgeInsets.all(10),
        child: Material(
            borderRadius: borderRadius,
            color: buttonColor.color,
            child: InkWell(
                onTap: () {
                  colors.showCanvasColorDeleteButtons = false;
                  onButtonTap();
                },
                borderRadius: borderRadius,
                child: Tooltip(
                    message: tooltipMessage,
                    preferBelow: false,
                    child: Icon(
                      icon,
                      color: uiTextColor.color,
                      size: 40,
                    )))));
  }
}
