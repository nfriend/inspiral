import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

class StrokeSelectorThumbnail extends StatelessWidget {
  final double width;
  final bool isActive;
  final Function onStrokeTap;

  StrokeSelectorThumbnail(
      {@required this.width,
      @required this.isActive,
      @required this.onStrokeTap});

  @override
  Widget build(BuildContext context) {
    var colors = Provider.of<ColorState>(context);
    final BorderRadius borderRadius = BorderRadius.all(Radius.circular(5.0));

    Color lineColor = colors.uiTextColor.color;
    if (isActive) {
      lineColor = colors.isDark ? Colors.black : Colors.white;
    }

    return Padding(
        padding: EdgeInsets.all(10),
        child: Material(
            borderRadius: borderRadius,
            color:
                isActive ? colors.activeColor.color : colors.buttonColor.color,
            child: InkWell(
                onTap: onStrokeTap,
                borderRadius: borderRadius,
                child: Center(
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(width: width, color: lineColor))))));
  }
}
