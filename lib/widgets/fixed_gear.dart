import 'package:flutter/material.dart';
import 'package:inspiral/widgets/color_filters.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';

class FixedGear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gear = context.watch<FixedGearState>();

    if (!gear.isVisible) {
      return Container();
    }

    final pointers = Provider.of<PointersState>(context, listen: false);
    final colors = context.watch<ColorState>();

    final colorFilter =
        colors.isDark ? fixedGearInvertedColorFilter : fixedGearColorFilter;

    var widgetContent = Transform.translate(
        offset: gear.position - gear.definition.center,
        child: Transform.rotate(
          origin:
              gear.definition.center - gear.definition.size.toOffset() / 2.0,
          angle: gear.rotation,
          child: Listener(
              onPointerDown: (event) {
                pointers.pointerDown(event);
                gear.gearPointerDown(event);
              },
              onPointerMove: gear.gearPointerMove,
              onPointerUp: (event) {
                pointers.pointerUp(event);
                gear.gearPointerUp(event);
              },
              child: ColorFiltered(
                  colorFilter: colorFilter,
                  child: Image.asset(gear.definition.image,
                      width: gear.definition.size.width,
                      height: gear.definition.size.height))),
        ));

    // When the gear is locked, prevent this widget from absorbing pointer
    // events. Instead, allow the user to manipulate the canvas through
    // the fixed gear.
    return gear.isLocked ? IgnorePointer(child: widgetContent) : widgetContent;
  }
}
