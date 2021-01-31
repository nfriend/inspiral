import 'package:flutter/material.dart';
import 'package:inspiral/widgets/color_filters.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';

class FixedGear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gear = context.watch<FixedGearState>();

    return Transform.translate(
        offset: gear.position - gear.definition.size.toOffset() / 2,
        child: Transform.rotate(
          angle: gear.rotation,
          child: Listener(
              onPointerDown: gear.gearPointerDown,
              onPointerMove: gear.gearPointerMove,
              onPointerUp: gear.gearPointerUp,
              child: ColorFiltered(
                  colorFilter: fixedGearColorFilter,
                  child: Image.asset(gear.definition.image,
                      width: gear.definition.size.width,
                      height: gear.definition.size.height))),
        ));
  }
}
