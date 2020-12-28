import 'package:flutter/material.dart';
import 'package:inspiral/models/canvas_model.dart';
import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/models/fixed_gear_model.dart';
import 'package:inspiral/models/gear_definitions.dart';
import 'package:inspiral/models/rotating_gear_model.dart';
import 'package:inspiral/routes.dart';
import 'package:inspiral/widgets/inspiral_canvas.dart';
import 'package:provider/provider.dart';

class InspiralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => CanvasModel(rotation: 0, zoom: 1),
          ),
          ChangeNotifierProvider(
              create: (context) => RotatingGearModel(
                  initialOffset: Offset(100, 100),
                  initialGearDefinition: GearDefinitions.defaultRotatingGear)),
          ChangeNotifierProxyProvider<RotatingGearModel, FixedGearModel>(
              create: (context) => FixedGearModel(
                  initialOffset: Offset(100, 300),
                  initialGearDefinition: GearDefinitions.defaultFixedGear),
              update: (context, rotatingGear, fixedGear) {
                rotatingGear.fixedGear = fixedGear;
                fixedGear.rotatingGear = rotatingGear;

                return fixedGear;
              }),
        ],
        child: MaterialApp(
          title: 'Inspiral',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            InspiralRoutes.canvas: (context) {
              return InspiralCanvas();
            }
          },
        ));
  }
}
