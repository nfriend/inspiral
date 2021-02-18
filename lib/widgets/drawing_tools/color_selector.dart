import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/drawing_tools/color_selector_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/selection_row.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

@immutable
class _RowDefinition {
  final String label;
  final Iterable<TinyColor> colorsToShow;
  final TinyColor activeColor;
  final void Function(TinyColor newColor) onColorSelect;

  _RowDefinition(
      {@required this.label,
      @required this.colorsToShow,
      @required this.activeColor,
      @required this.onColorSelect});
}

class ColorSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorState>(context);

    List<_RowDefinition> rowDefs = [
      _RowDefinition(
          label: 'PEN',
          colorsToShow: [
            TinyColor(Colors.red),
            TinyColor(Colors.green),
            TinyColor(Colors.blue),
            TinyColor(Color(0xAA088020))
          ],
          activeColor: colors.penColor,
          onColorSelect: (TinyColor newColor) {
            colors.penColor = newColor;
          }),
      _RowDefinition(
          label: 'CANVAS',
          colorsToShow: [
            TinyColor(Colors.yellow),
            TinyColor(Colors.cyan),
            TinyColor(Colors.purple),
            TinyColor(Color(0xFFF7EFDA))
          ],
          activeColor: colors.backgroundColor,
          onColorSelect: (TinyColor newColor) {
            colors.backgroundColor = newColor;
          }),
    ];

    final double padding = 2.5;

    return Padding(
        padding: EdgeInsets.all(2.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var def in rowDefs)
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(padding),
                      child: SelectionRow(
                        label: def.label,
                        children: [
                          for (var color in def.colorsToShow)
                            ColorSelectorThumbnail(
                                color: color,
                                isActive: color.color == def.activeColor.color,
                                onColorTap: () {
                                  def.onColorSelect(color);
                                })
                        ],
                      ))),
          ],
        ));
  }
}
