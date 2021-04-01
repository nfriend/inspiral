import 'package:flutter/material.dart';
import 'package:inspiral/models/entitlement.dart';
import 'package:inspiral/models/package.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/drawing_tools/action_button.dart';
import 'package:inspiral/widgets/drawing_tools/color_selector_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/new_color_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/selection_row.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:inspiral/util/custom_icons.dart';

class ToolsSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PurchasesState purchases =
        Provider.of<PurchasesState>(context, listen: false);
    final ColorState colors = Provider.of<ColorState>(context);
    final rotatingGear = Provider.of<RotatingGearState>(context, listen: false);

    return SelectionRows(rowDefs: [
      SelectionrRowDefinition(storageKey: "tools", label: 'TOOLS', children: [
        ActionButton(
          icon: InspiralCustomIcons.forward_1,
          tooltipMessage: "Rotate in place clockwise by one tooth",
          onButtonTap: () {
            rotatingGear.rotateInPlace(teethToRotate: -1);
          },
        ),
        ActionButton(
          icon: InspiralCustomIcons.backwards_1,
          tooltipMessage: "Rotate in place counterclockwise by one tooth",
          onButtonTap: () {
            rotatingGear.rotateInPlace(teethToRotate: 1);
          },
        ),
        ActionButton(
          icon: Icons.refresh,
          tooltipMessage: "Draw one rotation",
          onButtonTap: () {
            rotatingGear.drawOneRotation();
          },
        ),
        ActionButton(
          icon: InspiralCustomIcons.rotate_complete,
          tooltipMessage: "Draw complete pattern",
          onButtonTap: () {
            rotatingGear.drawCompletePattern();
          },
        ),
      ]),
      SelectionrRowDefinition(
          storageKey: "canvasColor",
          label: 'CANVAS',
          children: [
            for (TinyColor color in colors.availableCanvasColors)
              FutureBuilder(
                  future: purchases
                      .isEntitledTo(Entitlement.custombackgroundcolors),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    bool showDeleteButton = snapshot.hasData &&
                        snapshot.data &&
                        colors.showCanvasColorDeleteButtons;

                    return ColorSelectorThumbnail(
                        color: color,
                        isActive: color.color == colors.backgroundColor.color,
                        onColorTap: () => colors.backgroundColor = color,
                        onColorLongPress: () =>
                            colors.showCanvasColorDeleteButtons =
                                !colors.showCanvasColorDeleteButtons,
                        onColorDelete: () => colors.removeCanvasColor(color),
                        showDeleteButton: showDeleteButton);
                  }),
            NewColorThumbnail(
                title: "New canvas color",
                entitlement: Entitlement.custombackgroundcolors,
                package: Package.custombackgroundcolors,
                showOpacity: false,
                initialColor: colors.lastSelectedCustomCanvasColor.color,
                onSelect: (color) {
                  colors.addAndSelectCanvasColor(TinyColor(color));
                }),
          ]),
    ]);
  }
}
