import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class ActionButton extends StatelessWidget {
  final IconData? icon;
  final Widget? buttonContent;
  final String tooltipMessage;
  final Function onButtonTap;
  final bool isActive;
  final bool isDisabled;

  ActionButton(
      {this.icon,
      this.buttonContent,
      required this.tooltipMessage,
      required this.onButtonTap,
      this.isActive = false,
      this.isDisabled = false}) {
    assert((icon == null) ^ (buttonContent == null),
        'Exactly one of the `icon` and `buttonContent` parameters must be non-null');
  }

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorState>(context, listen: false);

    final buttonColor = isActive
        ? context.select<ColorState, TinyColor>((colors) => colors.activeColor)
        : context.select<ColorState, TinyColor>((colors) => colors.buttonColor);

    var uiTextColor = isActive
        ? context
            .select<ColorState, TinyColor>((colors) => colors.activeTextColor)
        : context.select<ColorState, TinyColor>((colors) => colors.uiTextColor);

    if (isDisabled) {
      uiTextColor = TinyColor(uiTextColor.color.withOpacity(0.25));
    }

    final borderRadius = BorderRadius.all(Radius.circular(5.0));

    return Padding(
        padding: EdgeInsets.all(10),
        child: Material(
            borderRadius: borderRadius,
            color: buttonColor.color,
            child: InkWell(
                onTap: isDisabled
                    ? null
                    : () {
                        colors.showCanvasColorDeleteButtons = false;
                        onButtonTap();
                      },
                borderRadius: borderRadius,
                child: Tooltip(
                    message: tooltipMessage,
                    preferBelow: false,
                    child: buttonContent ??
                        Icon(
                          icon,
                          color: uiTextColor.color,
                          size: 40,
                        )))));
  }
}
