import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/widgets/inspiral_providers.dart';
import 'package:inspiral/routes.dart';
import 'package:inspiral/widgets/drawing_board.dart';

class InspiralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldGlobalKey,
      title: 'Inspiral',
      routes: {
        InspiralRoutes.canvas: (context) =>
            InspiralProviders(child: DrawingBoard())
      },
    );
  }
}
