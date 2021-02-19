import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/drawing_tools/color_selector_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/selection_row.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class ColorSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorState>(context);

    final List<TinyColor> penColors = [
      TinyColor(Color(0x66FF0000)),
      TinyColor(Color(0xB3FF9500)),
      TinyColor(Color(0xB3FFFF00)),
      TinyColor(Color(0x80009600)),
      TinyColor(Color(0x660000FF)),
      TinyColor(Color(0x80960096)),
      TinyColor(Color(0xCCFFFFFF)),
      TinyColor(Color(0xCCC8C8C8)),
      TinyColor(Color(0xCC969696)),
      TinyColor(Color(0xCC646464)),
    ];

    return SelectionRows(rowDefs: [
      SelectionrRowDefinition(label: 'COLOR', children: [
        for (TinyColor color in penColors)
          ColorSelectorThumbnail(
              color: color,
              isActive: color.color == colors.penColor.color,
              onColorTap: () => colors.penColor = color)
      ]),
      SelectionrRowDefinition(label: 'COLOR', children: [
        for (TinyColor color in penColors)
          ColorSelectorThumbnail(
              color: color,
              isActive: color.color == colors.penColor.color,
              onColorTap: () => colors.penColor = color)
      ]),
    ]);
  }
}
