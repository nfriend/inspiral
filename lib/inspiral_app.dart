import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/util/hide_system_ui_overlays.dart';
import 'package:inspiral/widgets/help_page.dart';
import 'package:inspiral/widgets/inspiral_providers.dart';
import 'package:inspiral/routes.dart';
import 'package:inspiral/widgets/drawing_board.dart';
import 'package:inspiral/widgets/android_back_button_handler.dart';

class InspiralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    hideSystemUIOverlays();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerGlobalKey,
      title: 'Inspiral',
      routes: {
        InspiralRoutes.canvas: (context) => InspiralProviders(
            child: AndroidBackButtonHandler(child: DrawingBoard())),
        InspiralRoutes.help: (context) => HelpPage()
      },
    );
  }
}
