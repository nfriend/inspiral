import 'package:flutter/material.dart';
import 'package:inspiral/models/ink_line.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/drawing_tools/crown_image.dart';
import 'package:provider/provider.dart';

class StrokeSelectorThumbnail extends StatelessWidget {
  final double width;
  final StrokeStyle style;
  final bool isActive;
  final bool isPremium;
  final Function onStrokeTap;

  StrokeSelectorThumbnail(
      {@required this.width,
      @required this.style,
      @required this.isActive,
      @required this.onStrokeTap,
      this.isPremium = false});

  @override
  Widget build(BuildContext context) {
    var colors = Provider.of<ColorState>(context);
    final BorderRadius borderRadius = BorderRadius.all(Radius.circular(5.0));

    Color buttonColor =
        isActive ? colors.activeColor.color : colors.buttonColor.color;

    Widget line;
    if (style == StrokeStyle.normal) {
      Color lineColor = colors.uiTextColor.color;
      if (isActive) {
        lineColor = colors.isDark ? Colors.black : Colors.white;
      }

      line = Container(width: width, color: lineColor);
    } else {
      Color airbrushColor = Colors.black87;
      if ((colors.isDark && !isActive) || (!colors.isDark && isActive)) {
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

    final Widget crown = isPremium ? CrownImage() : Container();

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
      crown
    ]);
  }
}
