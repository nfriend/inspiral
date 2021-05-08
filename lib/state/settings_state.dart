import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/state/persistors/settings_state_persistor.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/find_closest_compatible_gear.dart';
import 'package:sqflite/sqlite_api.dart';

class SettingsState extends InspiralStateObject {
  static SettingsState _instance;

  factory SettingsState.init() {
    return _instance = SettingsState._internal();
  }

  factory SettingsState() {
    assert(_instance != null,
        'The SettingsState.init() factory constructor must be called before using the SettingsState() constructor.');
    return _instance;
  }

  SettingsState._internal() : super();

  /// Whether or not to show various debugging aids
  bool get debug => _debug;
  bool _debug = !kReleaseMode && !kProfileMode;
  set debug(bool value) {
    _debug = value;
    notifyListeners();
  }

  /// Whether or not to include the background color when saving images
  bool get includeBackgroundWhenSaving => _includeBackgroundWhenSaving;
  bool _includeBackgroundWhenSaving = true;
  set includeBackgroundWhenSaving(bool value) {
    _includeBackgroundWhenSaving = value;
    notifyListeners();
  }

  /// Whether or not to close the drawing tools drawer (and keep it closed)
  /// when either gear is dragged
  bool get closeDrawingToolsDrawerOnDrag => _closeDrawingToolsDrawerOnDrag;
  bool _closeDrawingToolsDrawerOnDrag = false;
  set closeDrawingToolsDrawerOnDrag(bool value) {
    _closeDrawingToolsDrawerOnDrag = value;
    notifyListeners();
  }

  /// Whether to prevent incompatible gear pairings from being selected
  bool get preventIncompatibleGearPairings => _preventIncompatibleGearPairings;
  bool _preventIncompatibleGearPairings = true;
  set preventIncompatibleGearPairings(bool value) {
    _preventIncompatibleGearPairings = value;

    // If an incompatible pairing is selected when this setting is enabled,
    // update the rotating gear selection to ensure compatibility.
    if (_preventIncompatibleGearPairings == true) {
      allStateObjects.rotatingGear.selectNewGear(findClosestCompatibleGear(
          fixedGear: allStateObjects.fixedGear.definition,
          currentlySelectedRotatingGear:
              allStateObjects.rotatingGear.definition));
    }

    notifyListeners();
  }

  @override
  void persist(Batch batch) {
    SettingsStatePersistor.persist(batch, this);
  }

  @override
  Future<void> rehydrate(Database db, BuildContext context) async {
    var result = await SettingsStatePersistor.rehydrate(db, this);

    _includeBackgroundWhenSaving = result.includeBackgroundWhenSaving;
    _closeDrawingToolsDrawerOnDrag = result.closeDrawingToolsDrawerOnDrag;
    _preventIncompatibleGearPairings = result.preventIncompatibleGearPairings;
  }
}
