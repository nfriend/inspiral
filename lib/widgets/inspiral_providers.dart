import 'package:flutter/material.dart';
import 'package:inspiral/state/init_state.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';

class InspiralProviders extends StatelessWidget {
  InspiralProviders({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Initialize all the singletons that will be provided below
    initState(context);

    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SettingsState()),
      ChangeNotifierProvider(create: (context) => PointersState()),
      ChangeNotifierProvider(create: (context) => CanvasState()),
      ChangeNotifierProvider(create: (context) => RotatingGearState()),
      ChangeNotifierProvider(create: (context) => DragLineState()),
      ChangeNotifierProvider(create: (context) => FixedGearState())
    ], child: child);
  }
}
