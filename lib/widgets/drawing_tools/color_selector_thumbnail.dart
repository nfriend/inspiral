import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class ColorSelectorThumbnail extends StatelessWidget {
  final TinyColor color;
  final bool isActive;
  final void Function() onColorTap;
  final void Function() onColorDelete;
  final void Function() onColorLongPress;
  final bool showDeleteButton;

  ColorSelectorThumbnail(
      {@required this.color,
      @required this.isActive,
      @required this.onColorTap,
      @required this.onColorLongPress,
      @required this.onColorDelete,
      @required this.showDeleteButton});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<ColorState, bool>((colors) => colors.isDark);
    final activeColor =
        context.select<ColorState, TinyColor>((colors) => colors.activeColor);
    final outerBorderRadius = BorderRadius.all(Radius.circular(10.0));
    final innerBorderRadius = BorderRadius.all(Radius.circular(5.0));
    final deleteButtonSize = 30.0;

    return GestureDetector(
        onLongPress: onColorLongPress,
        child: Stack(children: [
          Container(
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
                        color: color.color,
                        borderRadius: innerBorderRadius,
                        child: InkWell(
                          borderRadius: innerBorderRadius,
                          onTap: onColorTap,
                        ))),
              )),
          showDeleteButton
              ? Positioned(
                  top: 0.0,
                  left: 0.0,
                  child: Container(
                      width: deleteButtonSize,
                      height: deleteButtonSize,
                      decoration: BoxDecoration(
                          color: isDark ? Color(0xFF333333) : Color(0xFFEEEEEE),
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 2.0,
                              color: isDark
                                  ? Color(0xFFAAAAAA)
                                  : Color(0xFF555555))),
                      child: Material(
                          type: MaterialType.transparency,
                          shape: CircleBorder(),
                          child: InkWell(
                            onTap: onColorDelete,
                            borderRadius: BorderRadius.all(
                                Radius.circular(deleteButtonSize)),
                            child: Icon(Icons.clear, size: 17.0),
                          ))))
              : Container()
        ]));
  }
}
