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
    Future<void> stateFuture = initState(context);

    return FutureBuilder(
        future: stateFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasError) {
            throw ("Something went wrong while initializing state! ${snapshot.error}");
          } else if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(providers: [
              ChangeNotifierProvider(create: (context) => SettingsState()),
              ChangeNotifierProvider(create: (context) => PointersState()),
              ChangeNotifierProvider(create: (context) => CanvasState()),
              ChangeNotifierProvider(create: (context) => RotatingGearState()),
              ChangeNotifierProvider(create: (context) => DragLineState()),
              ChangeNotifierProvider(create: (context) => FixedGearState())
            ], child: child);
          } else {
            // TODO: Do we need a real loading state here?
            // If the startup time is slow enough, consider
            // showing a splash screen of some kind here.
            return Container(color: Colors.white);
          }
        });
  }
}
