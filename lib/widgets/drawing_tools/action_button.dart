import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

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
    var colors = Provider.of<ColorState>(context);
    final BorderRadius borderRadius = BorderRadius.all(Radius.circular(5.0));

    return Padding(
        padding: EdgeInsets.all(10),
        child: Material(
            borderRadius: borderRadius,
            color: colors.buttonColor.color,
            child: InkWell(
                onTap: onButtonTap,
                borderRadius: borderRadius,
                child: Tooltip(
                    message: tooltipMessage,
                    preferBelow: false,
                    child: Icon(
                      icon,
                      color: colors.uiTextColor.color,
                      size: 40,
                    )))));
  }
}
