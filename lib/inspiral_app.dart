import 'package:flutter/material.dart';
import 'package:inspiral/models/canvas_model.dart';
import 'package:inspiral/models/fixed_gear_model.dart';
import 'package:inspiral/models/gear_definitions.dart';
import 'package:inspiral/models/pointer_model.dart';
import 'package:inspiral/models/rotating_gear_model.dart';
import 'package:inspiral/routes.dart';
import 'package:inspiral/widgets/inspiral_canvas.dart';
import 'package:provider/provider.dart';

class InspiralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PointersModel()),
          ChangeNotifierProxyProvider<PointersModel, CanvasModel>(
              create: (context) =>
                  CanvasModel(initialTransform: Matrix4.identity()),
              update: (context, pointers, canvas) {
                canvas.pointers = pointers;
                return canvas;
              }),
          ChangeNotifierProxyProvider<PointersModel, RotatingGearModel>(
              create: (context) => RotatingGearModel(
                  initialOffset: Offset(100, 100),
                  initialGearDefinition: GearDefinitions.defaultRotatingGear),
              update: (context, pointers, rotatingGear) {
                rotatingGear.pointers = pointers;
                return rotatingGear;
              }),
          ChangeNotifierProxyProvider2<PointersModel, RotatingGearModel,
                  FixedGearModel>(
              create: (context) => FixedGearModel(
                  initialOffset: Offset(100, 300),
                  initialGearDefinition: GearDefinitions.defaultFixedGear),
              update: (context, pointers, rotatingGear, fixedGear) {
                fixedGear.pointers = pointers;
                fixedGear.rotatingGear = rotatingGear;
                rotatingGear.fixedGear = fixedGear;
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
