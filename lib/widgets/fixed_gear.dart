import 'package:flutter/material.dart';
import 'package:inspiral/models/fixed_gear_model.dart';
import 'package:provider/provider.dart';

class FixedGear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gear = context.watch<FixedGearModel>();

    return Transform.translate(
      offset: Offset(gear.offset.dx, gear.offset.dy),
      child: Listener(
          onPointerDown: gear.gearPointerDown,
          child: Image.asset(gear.gearDefinition.image, width: 100)),
    );
  }
}
