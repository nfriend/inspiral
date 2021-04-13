import 'package:flutter/material.dart';
import 'package:inspiral/models/ink_line.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/drawing_tools/crown_if_not_entitled.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class StrokeSelectorThumbnail extends StatelessWidget {
  final double width;
  final StrokeStyle style;
  final bool isActive;
  final String package;
  final String entitlement;
  final void Function() onStrokeTap;

  StrokeSelectorThumbnail(
      {@required this.width,
      @required this.style,
      @required this.isActive,
      @required this.onStrokeTap,
      @required this.entitlement,
      @required this.package});

  @override
  Widget build(BuildContext context) {
    final themeButtonColor =
        context.select<ColorState, TinyColor>((colors) => colors.buttonColor);
    final uiTextColor =
        context.select<ColorState, TinyColor>((colors) => colors.uiTextColor);
    final activeColor =
        context.select<ColorState, TinyColor>((colors) => colors.activeColor);
    final isDark = context.select<ColorState, bool>((colors) => colors.isDark);
    final borderRadius = BorderRadius.all(Radius.circular(5.0));

    var buttonColor = isActive ? activeColor.color : themeButtonColor.color;

    Widget line;
    if (style == StrokeStyle.normal) {
      var lineColor = uiTextColor.color;
      if (isActive) {
        lineColor = isDark ? Colors.black : Colors.white;
      }

      line = Container(width: width, color: lineColor);
    } else {
      var airbrushColor = Colors.black87;
      if ((isDark && !isActive) || (!isDark && isActive)) {
        airbrushColor = Colors.white70;
      }

      line = Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            width: width,
            decoration: BoxDecoration(color: buttonColor, boxShadow: [
              BoxShadow(
                  color: airbrushColor,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset.zero)
            ]),
          ));
    }

    return Stack(children: [
      Padding(
          padding: EdgeInsets.all(10),
          child: Material(
              borderRadius: borderRadius,
              color: buttonColor,
              child: InkWell(
                  onTap: onStrokeTap,
                  borderRadius: borderRadius,
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: line))))),
      CrownIfNotEntitled(entitlement: entitlement)
    ]);
  }
}
