import 'package:flutter/material.dart';
import 'package:inspiral/widgets/dynamic_theme.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';

class DrawingTools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ColorState>();
    double margin = 2.5;
    double iconSize = 18;

    return DynamicTheme(
        child: Container(
            color: colors.uiBackgroundColor.color,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: margin * 2),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: margin),
                            child: TextButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.edit, size: iconSize),
                                label: Text("PEN")))),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: margin),
                            child: TextButton.icon(
                                onPressed: () {},
                                style: TextButton.styleFrom(),
                                icon: Icon(Icons.palette, size: iconSize),
                                label: Text("COLORS")))),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: margin),
                            child: TextButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.settings, size: iconSize),
                                label: Text("GEARS"))))
                  ],
                ))));
  }
}
