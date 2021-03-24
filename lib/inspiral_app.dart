import 'dart:io' as io;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/widgets/inspiral_providers.dart';
import 'package:inspiral/routes.dart';
import 'package:inspiral/widgets/drawing_board.dart';

class InspiralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Test whether or not the phone has a notch
    bool hasNotch;
    if (io.Platform.isIOS) {
      // Not exactly sure why/how this works, but it does :shrug:
      // See https://stackoverflow.com/a/58849024/1063392
      hasNotch =
          ui.window.viewPadding.top > 0 && ui.window.viewPadding.bottom > 0;
    } else {
      // I haven't figured out a reliable way to detect notches in Android yet
      hasNotch = false;
    }

    // Hide the top status bar for phones that _don't_ have a notch
    if (hasNotch) {
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays([]);
    }

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

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
