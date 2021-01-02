import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/providers/providers.dart';
import 'package:inspiral/extensions/extensions.dart';

class FixedGear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gear = context.watch<FixedGearProvider>();
    final settings = context.watch<SettingsProvider>();

    List<Widget> stackChildren = [];

    stackChildren.add(Listener(
        onPointerDown: gear.gearPointerDown,
        onPointerMove: gear.gearPointerMove,
        onPointerUp: gear.gearPointerUp,
        child: Image.asset(gear.gearDefinition.image,
            width: gear.gearDefinition.size.width,
            height: gear.gearDefinition.size.height)));

    if (settings.debug) {
      stackChildren.add(IgnorePointer(
          child: Transform.translate(
              offset: (gear.gearDefinition.size.toOffset() / 2)
                  .translate(debugDotSize.width / -2, debugDotSize.height / -2),
              child: Image.asset("images/blue_dot.png"))));
    }

    return Transform.translate(
      offset: gear.position - gear.gearDefinition.size.toOffset() / 2,
      child: Stack(children: stackChildren),
    );
  }
}
