import 'package:flutter/material.dart';

class BaseState extends ChangeNotifier with WidgetsBindingObserver {
  BaseState() {
    WidgetsBinding.instance.addObserver(this);
  }

  /// Persists this object to the database
  Future<void> persist() async {}

  /// Rehydrates this object from the database
  Future<void> rehydrate() async {}

  /// When the app is paused, save the state of the object
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if ([
      AppLifecycleState.paused,
      AppLifecycleState.inactive,
      AppLifecycleState.detached
    ].contains(state)) {
      persist();
    }
  }
}
