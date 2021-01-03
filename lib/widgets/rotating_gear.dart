import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/providers/providers.dart';
import 'package:inspiral/extensions/extensions.dart';

class RotatingGear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gear = context.watch<RotatingGearProvider>();
    final dragLine = Provider.of<DragLineProvider>(context, listen: false);

    return Transform.translate(
      offset: gear.position - gear.definition.size.toOffset() / 2,
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
          child: Image.asset(gear.definition.image,
              width: gear.definition.size.width,
              height: gear.definition.size.height)),
    );
  }
}
