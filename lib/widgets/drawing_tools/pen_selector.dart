import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/drawing_tools/color_selector_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/selection_row.dart';
import 'package:inspiral/widgets/drawing_tools/stroke_selector_thumbnail.dart';
import 'package:inspiral/models/ink_line.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

@immutable
class _StrokeAndStyle {
  final double width;
  final StrokeStyle style;

  _StrokeAndStyle({this.width, this.style});
}

final List<TinyColor> _penColors = [
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

final List<_StrokeAndStyle> _strokeOptions = [
  _StrokeAndStyle(width: 1.0, style: StrokeStyle.normal),
  _StrokeAndStyle(width: 3.0, style: StrokeStyle.normal),
  _StrokeAndStyle(width: 5.0, style: StrokeStyle.normal),
  _StrokeAndStyle(width: 7.5, style: StrokeStyle.normal),
  _StrokeAndStyle(width: 12.5, style: StrokeStyle.normal),
  _StrokeAndStyle(width: 15.0, style: StrokeStyle.normal),
  _StrokeAndStyle(width: 20.0, style: StrokeStyle.normal),
  _StrokeAndStyle(width: 30.0, style: StrokeStyle.normal),
  _StrokeAndStyle(width: 5.0, style: StrokeStyle.airbrush),
  _StrokeAndStyle(width: 7.5, style: StrokeStyle.airbrush),
  _StrokeAndStyle(width: 12.5, style: StrokeStyle.airbrush),
  _StrokeAndStyle(width: 15.0, style: StrokeStyle.airbrush),
  _StrokeAndStyle(width: 20.0, style: StrokeStyle.airbrush),
];

class PenSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorState>(context);
    final stroke = Provider.of<StrokeState>(context);

    return SelectionRows(rowDefs: [
      SelectionrRowDefinition(label: 'STYLE', children: [
        for (_StrokeAndStyle options in _strokeOptions)
          StrokeSelectorThumbnail(
              width: options.width,
              style: options.style,
              isActive: options.width == stroke.width &&
                  options.style == stroke.style,
              onStrokeTap: () {
                stroke.setStroke(width: options.width, style: options.style);
              })
      ]),
      SelectionrRowDefinition(label: 'COLOR', children: [
        for (TinyColor color in _penColors)
          ColorSelectorThumbnail(
              color: color,
              isActive: color.color == colors.penColor.color,
              onColorTap: () => colors.penColor = color)
      ]),
    ]);
  }
}
