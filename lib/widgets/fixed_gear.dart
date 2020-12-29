import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:provider/provider.dart';

class FixedGear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gear = context.watch<FixedGearModel>();
    final canvas = Provider.of<CanvasModel>(context, listen: false);

    return Transform.translate(
      offset: gear.position.scale(1, -1),
      child: Listener(
          onPointerDown: (event) {
            final transformedPosition =
                canvas.toCanvasCoordinates(event.position, context);

            gear.gearPointerDown(transformedPosition, event);
          },
          child: Image.asset(gear.gearDefinition.image,
              width: gear.gearDefinition.size.width,
              height: gear.gearDefinition.size.height)),
    );
  }
}
