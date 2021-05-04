import 'package:flutter/material.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/state/initialize_all_state_singletons.dart';
import 'package:inspiral/state/persistors/persistable.dart';
import 'package:inspiral/state/snackbar_state.dart';
import 'package:inspiral/state/stroke_state.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';

class InspiralProviders extends StatefulWidget {
  final Widget child;

  InspiralProviders({@required this.child});

  @override
  _InspiralProvidersState createState() => _InspiralProvidersState();
}

class _InspiralProvidersState extends State<InspiralProviders>
    with WidgetsBindingObserver {
  Future<Iterable<Persistable>> _stateFuture;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    // Initialize all the singletons that will be provided below
    _stateFuture ??= initializeAllStateSingletons(context);

    return FutureBuilder(
        future: _stateFuture,
        builder: (BuildContext context,
            AsyncSnapshot<Iterable<Persistable>> snapshot) {
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

      var db = await getDatabase();

      await db.transaction((txn) async {
        var batch = txn.batch();

        allStateObjects.forEach((state) => state.persist(batch));

        await batch.commit(noResult: true);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
