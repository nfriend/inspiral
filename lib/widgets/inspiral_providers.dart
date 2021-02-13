import 'package:flutter/material.dart';
import 'package:inspiral/state/init_state.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';

class InspiralProviders extends StatefulWidget {
  final Widget child;

  InspiralProviders({@required this.child});

  @override
  _InspiralProvidersState createState() => _InspiralProvidersState();
}

class _InspiralProvidersState extends State<InspiralProviders> {
  Future<void> _stateFuture;

  @override
  Widget build(BuildContext context) {
    // Initialize all the singletons that will be provided below
    if (_stateFuture == null) {
      _stateFuture = initState(context);
    }

    return FutureBuilder(
        future: _stateFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasError) {
            throw ("Something went wrong while initializing state! ${snapshot.error}");
          } else if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(providers: [
              ChangeNotifierProvider(create: (context) => SettingsState()),
              ChangeNotifierProvider(create: (context) => ProgressState()),
              ChangeNotifierProvider(create: (context) => ColorState()),
              ChangeNotifierProvider(create: (context) => InkState()),
              ChangeNotifierProvider(create: (context) => PointersState()),
              ChangeNotifierProvider(create: (context) => CanvasState()),
              ChangeNotifierProvider(create: (context) => RotatingGearState()),
              ChangeNotifierProvider(create: (context) => DragLineState()),
              ChangeNotifierProvider(create: (context) => FixedGearState())
            ], child: this.widget.child);
          } else {
            // TODO: Do we need a real loading state here?
            // If the startup time is slow enough, consider
            // showing a splash screen of some kind here.
            return Container(color: Colors.white);
          }
        });
  }
}
