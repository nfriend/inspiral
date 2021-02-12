import 'package:flutter/material.dart';
import 'package:inspiral/widgets/dynamic_theme.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';

@immutable
class _DrawingToolsButton {
  final Icon icon;
  final String text;
  final Function onPressed;

  _DrawingToolsButton({this.icon, this.text, this.onPressed});
}

class DrawingTools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ColorState>();
    double margin = 2.5;
    double iconSize = 18;

    List<_DrawingToolsButton> buttons = [
      _DrawingToolsButton(
          icon: Icon(Icons.edit, size: iconSize),
          text: 'PEN',
          onPressed: () {}),
      _DrawingToolsButton(
          icon: Icon(Icons.palette, size: iconSize),
          text: 'COLORS',
          onPressed: () {}),
      _DrawingToolsButton(
          icon: Icon(Icons.settings, size: iconSize),
          text: 'GEARS',
          onPressed: () {}),
    ];

    List<Widget> rowChildren = buttons
        .map((button) => Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: margin),
                child: TextButton.icon(
                    onPressed: button.onPressed,
                    icon: button.icon,
                    label: Text(button.text)))))
        .toList();

    return DynamicTheme(
        child: Container(
            color: colors.uiBackgroundColor.color,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: margin * 2),
                child: Row(
                  children: rowChildren,
                ))));
  }
}
