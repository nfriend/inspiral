import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/drawing_tools/action_button.dart';
import 'package:inspiral/widgets/drawing_tools/color_selector_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/selection_row.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:inspiral/util/custom_icons.dart';

class ToolsSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorState>(context);
    final rotatingGear = Provider.of<RotatingGearState>(context);

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
            for (TinyColor color in penColors)
              ColorSelectorThumbnail(
                  color: color,
                  isActive: color.color == colors.backgroundColor.color,
                  onColorTap: () => colors.backgroundColor = color)
          ]),
    ]);
  }
}
