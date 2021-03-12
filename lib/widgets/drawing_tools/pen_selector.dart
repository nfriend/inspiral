import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/if_purchased.dart';
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
  final Product product;

  const _StrokeAndStyle(
      {@required this.width,
      @required this.style,
      this.product = Product.free});
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
  const _StrokeAndStyle(width: 1.0, style: StrokeStyle.normal),
  const _StrokeAndStyle(width: 3.0, style: StrokeStyle.normal),
  const _StrokeAndStyle(width: 5.0, style: StrokeStyle.normal),
  const _StrokeAndStyle(width: 7.5, style: StrokeStyle.normal),
  const _StrokeAndStyle(width: 12.5, style: StrokeStyle.normal),
  const _StrokeAndStyle(width: 15.0, style: StrokeStyle.normal),
  const _StrokeAndStyle(width: 20.0, style: StrokeStyle.normal),
  const _StrokeAndStyle(width: 30.0, style: StrokeStyle.normal),
  const _StrokeAndStyle(
      width: 5.0, style: StrokeStyle.airbrush, product: Product.airbrushPens),
  const _StrokeAndStyle(
      width: 7.5, style: StrokeStyle.airbrush, product: Product.airbrushPens),
  const _StrokeAndStyle(
      width: 12.5, style: StrokeStyle.airbrush, product: Product.airbrushPens),
  const _StrokeAndStyle(
      width: 15.0, style: StrokeStyle.airbrush, product: Product.airbrushPens),
  const _StrokeAndStyle(
      width: 20.0, style: StrokeStyle.airbrush, product: Product.airbrushPens),
];

class PenSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TinyColor penColor =
        context.select<ColorState, TinyColor>((colors) => colors.penColor);
    final ColorState colors = Provider.of<ColorState>(context, listen: false);
    final StrokeStyle strokeStyle =
        context.select<StrokeState, StrokeStyle>((stroke) => stroke.style);
    final double strokeWidth =
        context.select<StrokeState, double>((stroke) => stroke.width);
    final StrokeState stroke = Provider.of<StrokeState>(context, listen: false);

    return SelectionRows(rowDefs: [
      SelectionrRowDefinition(
          storageKey: "penStyle",
          label: 'STYLE',
          children: [
            for (_StrokeAndStyle options in _strokeOptions)
              StrokeSelectorThumbnail(
                  width: options.width,
                  style: options.style,
                  isActive: options.width == strokeWidth &&
                      options.style == strokeStyle,
                  product: options.product,
                  onStrokeTap: ifPurchased(context, options.product, () {
                    stroke.setStroke(
                        width: options.width, style: options.style);
                  }))
          ]),
      SelectionrRowDefinition(
          storageKey: "penColor",
          label: 'COLOR',
          children: [
            for (TinyColor color in _penColors)
              ColorSelectorThumbnail(
                  color: color,
                  isActive: color.color == penColor.color,
                  onColorTap: () => colors.penColor = color)
          ]),
    ]);
  }
}
