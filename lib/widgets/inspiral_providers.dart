import 'package:flutter/material.dart';
import 'package:inspiral/state/initialize_all_state_singletons.dart';
import 'package:inspiral/state/snackbar_state.dart';
import 'package:inspiral/state/stroke_state.dart';
import 'package:inspiral/state/undo_redo_state.dart';
import 'package:inspiral/widgets/helpers/persist_all_state_objects.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';

class InspiralProviders extends StatefulWidget {
  final Widget child;

  InspiralProviders({required this.child});

  @override
  _InspiralProvidersState createState() => _InspiralProvidersState();
}

class _InspiralProvidersState extends State<InspiralProviders>
    with WidgetsBindingObserver {
  late Future<AllStateObjects> _stateFuture;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);

    _stateFuture = initializeAllStateSingletons(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _stateFuture,
        builder:
            (BuildContext context, AsyncSnapshot<AllStateObjects> snapshot) {
          if (snapshot.hasError) {
            throw ('Something went wrong while initializing state! ${snapshot.error}');
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
              ChangeNotifierProvider(create: (context) => FixedGearState()),
              ChangeNotifierProvider(create: (context) => ColorPickerState()),
              ChangeNotifierProvider(create: (context) => SnackbarState()),
              ChangeNotifierProvider(create: (context) => SnapPointState()),
              ChangeNotifierProvider(create: (context) => UndoRedoState()),
            ], child: widget.child);
          } else {
            // Note: If the startup time is slow enough, consider
            // showing a splash screen of some kind here.
            return Container(color: Colors.white);
          }
        });
  }

  /// When the app is paused, save the state of the object
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if ([
      AppLifecycleState.paused,
      AppLifecycleState.inactive,
      AppLifecycleState.detached
    ].contains(state)) {
      var allStateObjects = await _stateFuture;

      await persistAllStateObjects(allStateObjects);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
}
