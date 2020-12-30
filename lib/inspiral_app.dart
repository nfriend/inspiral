import 'package:flutter/material.dart';
import 'package:statsfl/statsfl.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/routes.dart';
import 'package:inspiral/widgets/inspiral_canvas.dart';
import 'package:inspiral/providers/providers.dart';

class InspiralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PointersProvider()),
          ChangeNotifierProxyProvider<PointersProvider, CanvasProvider>(
              create: (context) =>
                  CanvasProvider(initialTransform: Matrix4.identity()),
              update: (context, pointers, canvas) {
                canvas.pointers = pointers;
                return canvas;
              }),
          ChangeNotifierProxyProvider<PointersProvider, RotatingGearProvider>(
              create: (context) => RotatingGearProvider(
                  initialOffset: Offset(0, 0),
                  initialGearDefinition: GearDefinitions.defaultRotatingGear),
              update: (context, pointers, rotatingGear) {
                rotatingGear.pointers = pointers;
                return rotatingGear;
              }),
          ChangeNotifierProxyProvider2<PointersProvider, RotatingGearProvider,
                  FixedGearProvider>(
              create: (context) => FixedGearProvider(
                  initialOffset: Offset(0, 0),
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
              return StatsFl(
                  child: Stack(children: [
                OverflowBox(
                    maxHeight: canvasSize.height,
                    minHeight: canvasSize.height,
                    maxWidth: canvasSize.width,
                    minWidth: canvasSize.width,
                    alignment: Alignment.topLeft,
                    child: Container(
                        width: canvasSize.width,
                        height: canvasSize.height,
                        child: InspiralCanvas()))
              ]));
            }
          },
        ));
  }
}
