import 'package:flutter/material.dart';
import 'package:inspiral/widgets/color_filters.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:inspiral/constants.dart';
import 'package:tinycolor/tinycolor.dart';

class RotatingGear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gear = context.watch<RotatingGearState>();

    if (!gear.isVisible) {
      return Container();
    }

    final dragLine = Provider.of<DragLineState>(context, listen: false);
    final pointers = Provider.of<PointersState>(context, listen: false);
    final penColor =
        context.select<ColorState, TinyColor>((colors) => colors.penColor);
    final backgroundColor = context
        .select<ColorState, TinyColor>((colors) => colors.backgroundColor);

    final colorFilter =
        backgroundColor.isDark() ? invertColorFilter : noFilterColorFilter;

    final gearCenter = gear.definition.size.toOffset() / 2;

    // Compute the location of the ink dot (the pen). Multiplying by 1.5
    // due to the margin of the `Container` dot.
    final penPosition =
        gear.relativePenPosition + gearCenter - (inkDotSize.toOffset() * 1.5);

    return Transform.translate(
        offset: gear.position - gearCenter,
        child: Transform.rotate(
          angle: gear.rotation,
          child: Listener(
              onPointerDown: (event) {
                pointers.pointerDown(event);
                dragLine.gearPointerDown(event);
                gear.gearPointerDown(event);
              },
              onPointerMove: (event) {
                dragLine.gearPointerMove(event);
                gear.gearPointerMove(event);
              },
              onPointerUp: (event) {
                pointers.pointerUp(event);
                gear.gearPointerUp(event);
              },
              child: Stack(children: [
                ColorFiltered(
                    colorFilter: colorFilter,
                    child: Image.asset(gear.definition.image,
                        width: gear.definition.size.width,
                        height: gear.definition.size.height)),
                Transform.translate(
                    offset: penPosition,
                    child: Container(
                      margin: EdgeInsets.all(inkDotSize.width),
                      width: inkDotSize.width,
                      height: inkDotSize.height,
                      decoration: BoxDecoration(
                          color: penColor.color, shape: BoxShape.circle),
                    ))
              ])),
        ));
  }
}
