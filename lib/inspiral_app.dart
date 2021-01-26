import 'package:flutter/material.dart';
import 'package:inspiral/widgets/inspiral_providers.dart';
import 'package:inspiral/routes.dart';
import 'package:inspiral/widgets/inspiral_canvas.dart';

class InspiralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inspiral',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        InspiralRoutes.canvas: (context) =>
            InspiralProviders(child: InspiralCanvas())
      },
    );
  }
}
