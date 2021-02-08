import 'package:flutter/material.dart';
import 'package:inspiral/widgets/inspiral_providers.dart';
import 'package:inspiral/routes.dart';
import 'package:inspiral/widgets/inspiral_drawing_board.dart';

class InspiralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inspiral',
      routes: {
        InspiralRoutes.canvas: (context) =>
            InspiralProviders(child: InspiralDrawingBoard())
      },
    );
  }
}
