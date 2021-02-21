import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/drawing_tools/color_selector_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/selection_row.dart';
import 'package:inspiral/widgets/drawing_tools/stroke_selector_thumbnail.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class PenSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorState>(context);
    final stroke = Provider.of<StrokeState>(context);

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

    final List<double> strokeWidths = [
      1.0,
      3.0,
      5.0,
      7.5,
      10.0,
      12.5,
      15.0,
      20.0
    ];

    return SelectionRows(rowDefs: [
      SelectionrRowDefinition(label: 'STYLE', children: [
        for (double width in strokeWidths)
          StrokeSelectorThumbnail(
              width: width,
              isActive: width == stroke.width,
              onStrokeTap: () {
                stroke.width = width;
              })
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
