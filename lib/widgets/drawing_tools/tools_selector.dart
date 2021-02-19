import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/drawing_tools/color_selector_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/selection_row.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class ToolsSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorState>(context);

    final List<TinyColor> penColors = [
      TinyColor(Colors.white),
      TinyColor(Color(0xFFF0F0F0)),
      TinyColor(Color(0xFFE3E3E3)),
      TinyColor(Color(0xFFF7EFDA)),
      TinyColor(Color(0xFF3B2507)),
      TinyColor(Color(0xFF0E1247)),
      TinyColor(Color(0xFF333333)),
      TinyColor(Color(0xFF121212)),
    ];

    return SelectionRows(rowDefs: [
      SelectionrRowDefinition(label: 'CANVAS', children: [
        for (TinyColor color in penColors)
          ColorSelectorThumbnail(
              color: color,
              isActive: color.color == colors.backgroundColor.color,
              onColorTap: () => colors.backgroundColor = color)
      ]),
    ]);
  }
}
