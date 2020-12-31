import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/providers/providers.dart';

class FixedGear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gear = context.watch<FixedGearProvider>();

    return Transform.translate(
      offset: gear.position,
      child: Listener(
          onPointerDown: gear.gearPointerDown,
          onPointerMove: gear.gearPointerMove,
          onPointerUp: gear.gearPointerUp,
          child: Image.asset(gear.gearDefinition.image,
              width: gear.gearDefinition.size.width,
              height: gear.gearDefinition.size.height)),
    );
  }
}
