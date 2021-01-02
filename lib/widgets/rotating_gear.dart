import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/providers/providers.dart';
import 'package:inspiral/extensions/extensions.dart';

class RotatingGear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gear = context.watch<RotatingGearProvider>();
    final settings = context.watch<SettingsProvider>();
    final dragLine = Provider.of<DragLineProvider>(context, listen: false);

    List<Widget> stackChildren = [];

    stackChildren.add(Listener(
        onPointerDown: (event) {
          gear.gearPointerDown(event);
          dragLine.gearPointerDown(event);
        },
        onPointerMove: (event) {
          gear.gearPointerMove(event);
          dragLine.gearPointerMove(event);
        },
        onPointerUp: gear.gearPointerUp,
        child: Image.asset(gear.definition.image,
            width: gear.definition.size.width,
            height: gear.definition.size.height)));

    if (settings.debug) {
      stackChildren.add(IgnorePointer(
          child: Transform.translate(
              offset: (gear.definition.size.toOffset() / 2)
                  .translate(debugDotSize.width / -2, debugDotSize.height / -2),
              child: Image.asset("images/red_dot.png"))));
    }

    return Transform.translate(
      offset: gear.position - gear.definition.size.toOffset() / 2,
      child: Stack(children: stackChildren),
    );
  }
}
