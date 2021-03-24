import 'package:flutter/material.dart';
import 'package:inspiral/state/init_state.dart';
import 'package:inspiral/state/stroke_state.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';
import 'package:tinycolor/tinycolor.dart';

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
    TinyColor initialCanvasColor = TinyColor(Colors.white);

    // Initialize all the singletons that will be provided below
    if (_stateFuture == null) {
      _stateFuture = initState(context, initialCanvasColor: initialCanvasColor);
    }

    return FutureBuilder(
        future: _stateFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasError) {
            throw ("Something went wrong while initializing state! ${snapshot.error}");
          } else if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(providers: [
              ChangeNotifierProvider(create: (context) => SettingsState()),
              ChangeNotifierProvider(create: (context) => PurchasesState()),
              ChangeNotifierProvider(create: (context) => ProgressState()),
              ChangeNotifierProvider(
                  create: (context) => SelectorDrawerState()),
              ChangeNotifierProvider(create: (context) => ColorState()),
              ChangeNotifierProvider(create: (context) => StrokeState()),
              ChangeNotifierProvider(create: (context) => InkState()),
              ChangeNotifierProvider(create: (context) => PointersState()),
              ChangeNotifierProvider(create: (context) => CanvasState()),
              ChangeNotifierProvider(create: (context) => RotatingGearState()),
              ChangeNotifierProvider(create: (context) => DragLineState()),
              ChangeNotifierProvider(create: (context) => FixedGearState())
            ], child: this.widget.child);
          } else {
            // Note: If the startup time is slow enough, consider
            // showing a splash screen of some kind here.
            return Container(color: initialCanvasColor.color);
          }
        });
  }
}
