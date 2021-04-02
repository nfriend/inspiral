import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/if_purchased.dart';
import 'package:inspiral/widgets/drawing_tools/color_selector_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/new_color_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/no_color_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/selection_row.dart';
import 'package:inspiral/widgets/drawing_tools/stroke_selector_thumbnail.dart';
import 'package:inspiral/models/ink_line.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

@immutable
class _StrokeAndStyle {
  final double width;
  final StrokeStyle style;
  final String entitlement;
  final String package;

  const _StrokeAndStyle(
      {@required this.width,
      @required this.style,
      this.entitlement = Entitlement.free,
      this.package});
}

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
      width: 5.0,
      style: StrokeStyle.airbrush,
      package: Package.airbrushpens,
      entitlement: Entitlement.airbrushpens),
  const _StrokeAndStyle(
      width: 7.5,
      style: StrokeStyle.airbrush,
      package: Package.airbrushpens,
      entitlement: Entitlement.airbrushpens),
  const _StrokeAndStyle(
      width: 12.5,
      style: StrokeStyle.airbrush,
      package: Package.airbrushpens,
      entitlement: Entitlement.airbrushpens),
  const _StrokeAndStyle(
      width: 15.0,
      style: StrokeStyle.airbrush,
      package: Package.airbrushpens,
      entitlement: Entitlement.airbrushpens),
  const _StrokeAndStyle(
      width: 20.0,
      style: StrokeStyle.airbrush,
      package: Package.airbrushpens,
      entitlement: Entitlement.airbrushpens),
];

class PenSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorState colors = Provider.of<ColorState>(context);
    final PurchasesState purchases =
        Provider.of<PurchasesState>(context, listen: false);
    final StrokeStyle strokeStyle =
        context.select<StrokeState, StrokeStyle>((stroke) => stroke.style);
    final double strokeWidth =
        context.select<StrokeState, double>((stroke) => stroke.width);
    final StrokeState stroke = Provider.of<StrokeState>(context, listen: false);

    return SelectionRows(rowDefs: [
      SelectionrRowDefinition(
          storageKey: "penStyle",
          label: 'STYLE',
          children: _strokeOptions.map((_StrokeAndStyle options) {
            final Function setStrokeIfPurchased = ifPurchased(
                context: context,
                entitlement: options.entitlement,
                package: options.package,
                callbackIfPurchased: () {
                  stroke.setStroke(width: options.width, style: options.style);
                });

            return StrokeSelectorThumbnail(
                width: options.width,
                style: options.style,
                isActive: options.width == strokeWidth &&
                    options.style == strokeStyle,
                package: options.package,
                entitlement: options.entitlement,
                onStrokeTap: () {
                  colors.showPenColorDeleteButtons = false;
                  setStrokeIfPurchased();
                });
          }).toList()),
      SelectionrRowDefinition(
          storageKey: "penColor",
          label: 'COLOR',
          children: [
            NoColorThumbnail(
                isActive: colors.penColor.color == Colors.transparent,
                onColorTap: () {
                  colors.showPenColorDeleteButtons = false;
                  colors.penColor = TinyColor(Colors.transparent);
                }),
            for (TinyColor color in colors.availablePenColors)
              FutureBuilder(
                  future: purchases.isEntitledTo(Entitlement.custompencolors),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    bool showDeleteButton = snapshot.hasData &&
                        snapshot.data &&
                        colors.showPenColorDeleteButtons;

                    return ColorSelectorThumbnail(
                        color: color,
                        isActive: color.color == colors.penColor.color,
                        onColorTap: () {
                          colors.showPenColorDeleteButtons = false;
                          colors.penColor = color;
                        },
                        onColorLongPress: () =>
                            colors.showPenColorDeleteButtons =
                                !colors.showPenColorDeleteButtons,
                        onColorDelete: () => colors.removePenColor(color),
                        showDeleteButton: showDeleteButton);
                  }),
            NewColorThumbnail(
                title: "New pen color",
                entitlement: Entitlement.custompencolors,
                package: Package.custompencolors,
                showOpacity: true,
                initialColor: colors.lastSelectedCustomPenColor.color,
                onPress: () => colors.showPenColorDeleteButtons = false,
                onSelect: (color) {
                  colors.addAndSelectPenColor(TinyColor(color));
                })
          ]),
    ]);
  }
}
