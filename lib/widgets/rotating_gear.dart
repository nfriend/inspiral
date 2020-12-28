import 'package:flutter/material.dart';
import 'package:inspiral/models/rotating_gear_model.dart';
import 'package:provider/provider.dart';

class RotatingGear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gear = context.watch<RotatingGearModel>();

    return Transform.translate(
      offset: Offset(gear.position.dx, gear.position.dy),
      child: Listener(
          onPointerDown: gear.gearPointerDown,
          child: Image.asset(gear.gearDefinition.image)),
    );
  }
}
