import 'package:flutter/material.dart';
import 'package:inspiral/widgets/color_filters.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';

class RotatingGear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gear = context.watch<RotatingGearState>();
    final dragLine = Provider.of<DragLineState>(context, listen: false);

    return Transform.translate(
        offset: gear.position - gear.definition.size.toOffset() / 2,
        child: Transform.rotate(
          angle: gear.rotation,
          child: Listener(
              onPointerDown: (event) {
                dragLine.gearPointerDown(event);
                gear.gearPointerDown(event);
              },
              onPointerMove: (event) {
                dragLine.gearPointerMove(event);
                gear.gearPointerMove(event);
              },
              onPointerUp: gear.gearPointerUp,
              child: ColorFiltered(
                  colorFilter: noFilterColorFilter,
                  child: Image.asset(gear.definition.image,
                      width: gear.definition.size.width,
                      height: gear.definition.size.height))),
        ));
  }
}
