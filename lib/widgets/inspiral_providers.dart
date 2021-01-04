import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/providers/drag_line_provider.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/providers/providers.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:inspiral/models/gear_definitions.dart';

class InspiralProviders extends StatelessWidget {
  InspiralProviders({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Compute an initial canvas translation that will place the
    // center point of the canvas directly in the center of the screen
    // By default, the canvas's top-left corner is lined up with
    // the screen's top-left corner
    final Matrix4 initialCanvasTransform = Matrix4.identity();

    // First, move the center of the canvas to the
    // top-left of the screen
    Vector3 translation = -(canvasCenter.toVector3());

    // Then, move the canvas back by half the screen dimensions
    // so that the centor of the canvas is located
    // in the centr of the screen
    translation += (MediaQuery.of(context).size / 2).toVector3();

    initialCanvasTransform.translate(translation);

    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ChangeNotifierProvider(create: (context) => PointersProvider()),
      ChangeNotifierProxyProvider<PointersProvider, CanvasProvider>(
          create: (context) =>
              CanvasProvider(initialTransform: initialCanvasTransform),
          update: (context, pointers, canvas) {
            canvas.pointers = pointers;
            return canvas;
          }),
      ChangeNotifierProxyProvider<PointersProvider, RotatingGearProvider>(
          create: (context) => RotatingGearProvider(
              initialAngle: pi / 2,
              initialDefinition: GearDefinitions.defaultRotatingGear),
          update: (context, pointers, rotatingGear) {
            rotatingGear.pointers = pointers;
            return rotatingGear;
          }),
      ChangeNotifierProxyProvider2<CanvasProvider, RotatingGearProvider,
              DragLineProvider>(
          create: (context) => DragLineProvider(initialPosition: canvasCenter),
          update: (context, canvas, rotatingGear, dragLine) {
            dragLine.canvas = canvas;
            dragLine.rotatingGear = rotatingGear;
            rotatingGear.dragLine = dragLine;
            return dragLine;
          }),
      ChangeNotifierProxyProvider3<PointersProvider, DragLineProvider,
              RotatingGearProvider, FixedGearProvider>(
          create: (context) => FixedGearProvider(
              initialPosition: canvasCenter,
              initialDefinition: GearDefinitions.defaultFixedGear),
          update: (context, pointers, dragLine, rotatingGear, fixedGear) {
            fixedGear.pointers = pointers;
            fixedGear.rotatingGear = rotatingGear;
            fixedGear.dragLine = dragLine;
            rotatingGear.fixedGear = fixedGear;

            // TODO: This causes errors because it's changing a child's state
            // inside of build(). Refactor all of these providers into "state"
            // objects, where we can have more control over how they are
            // instantiated, how their dependencies are linked, and how
            // their initialization routines are run.
            rotatingGear.initializePosition();

            return fixedGear;
          }),
    ], child: child);
  }
}
