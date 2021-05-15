import 'package:flutter/material.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/state/persistors/undo_redo_state_persistor.dart';
import 'package:inspiral/state/state.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sqflite/sqflite.dart';

class UndoRedoState extends InspiralStateObject {
  static UndoRedoState _instance;

  factory UndoRedoState.init() {
    return _instance = UndoRedoState._internal();
  }

  factory UndoRedoState() {
    assert(_instance != null,
        'The UndoState.init() factory constructor must be called before using the UndoState() constructor.');
    return _instance;
  }

  UndoRedoState._internal() : super();

  @override
  void startListening() {
    _onInkChange = () {
      isInkBaking = allStateObjects.ink.isBaking;
    };

    allStateObjects.ink.addListener(_onInkChange);
  }

  @override
  void dispose() {
    allStateObjects.ink.removeListener(_onInkChange);

    super.dispose();
  }

  VoidCallback _onInkChange;

  /// Whether or not there is content that can be undone, and
  /// if it's okay to call undo right now (i.e., there are no
  /// pending operations that would prevent an undo).
  bool get undoAvailable =>
      !_isInkBaking &&
      !isUndoingOrRedoing &&
      !_isCreatingSnapshot &&
      currentSnapshotVersion > 0;

  /// Same as `undoAvailable`, but for redo
  bool get redoAvailable =>
      !_isInkBaking &&
      !isUndoingOrRedoing &&
      !_isCreatingSnapshot &&
      currentSnapshotVersion < maxSnapshotVersion;

  /// Whether or not the ink state is currently baking
  bool get isInkBaking => _isInkBaking;
  bool _isInkBaking = false;
  set isInkBaking(bool value) {
    if (_isInkBaking != value) {
      _isInkBaking = value;
      notifyListeners();
    }
  }

  /// Whether or not an undo operation is currently in progress
  bool get isUndoing => _isUndoing;
  bool _isUndoing = false;
  set isUndoing(bool value) {
    _isUndoing = value;
    notifyListeners();
  }

  /// Whether or not a redo operation is currently in progress
  bool get isRedoing => _isRedoing;
  bool _isRedoing = false;
  set isRedoing(bool value) {
    _isRedoing = value;
    notifyListeners();
  }

  /// Whether or not an undo or redo operation is currently in progress
  bool get isUndoingOrRedoing => _isUndoing || _isRedoing;

  /// The most recent active snapshot version.
  /// This will usually be equal to `maxSnapshotVersion`, except immediately
  /// after an undo. For example, if a user makes the following changes:
  ///
  /// 1 -> 2 -> 3 -> 4 -> 5
  ///
  /// And then presses "undo" twice, `currentSnapshotVersion` will be 3,
  /// while `maxSnapshotVersion` will be 5.
  ///
  /// If the user then begins to draw again, `maxSnapshotVersion` will
  /// be updated to 3.
  int get currentSnapshotVersion => _currentSnapshotVersion;
  int _currentSnapshotVersion;

  /// The last (i.e. farthest in the future) snapshot version.
  int get maxSnapshotVersion => _maxSnapshotVersion;
  int _maxSnapshotVersion;

  /// Whether or not the "snapshotting" process is currently in progress
  bool _isCreatingSnapshot = false;

  /// Moves backward one step in the undo/redo stack
  Future<void> triggerUndo() async {
    if (!undoAvailable) {
      return;
    }

    isUndoing = true;

    _currentSnapshotVersion--;

    notifyListeners();

    for (var stateObj in allStateObjects.list) {
      await stateObj.undo(currentSnapshotVersion);
    }

    isUndoing = false;

    notifyListeners();
  }

  /// Moves forward one step in the undo/redo stack
  Future<void> triggerRedo() async {}

  /// Creates a new state snapshot and adds it to the undo/redo stack
  Future<void> createSnapshot() async {
    // Don't try to create a new snapshot if it's already in progress
    if (_isCreatingSnapshot) {
      return;
    }

    _isCreatingSnapshot = true;

    notifyListeners();

    try {
      // Rasterize any un-baked points before creating a new snapshot
      await allStateObjects.ink.bakeImage();
      await allStateObjects.ink.pendingCanvasManipulation;

      var newVersion = _currentSnapshotVersion + 1;

      var batch = (await getDatabase()).batch();

      for (var stateObj in allStateObjects.list) {
        await stateObj.cleanUpOldRedoSnapshots(newVersion, batch);
      }

      for (var stateObj in allStateObjects.list) {
        await stateObj.snapshot(newVersion, batch);
      }

      await batch.commit(noResult: true);

      _currentSnapshotVersion = newVersion;
      _maxSnapshotVersion = newVersion;
    } catch (err, stackTrace) {
      // See comment in ink_state.dart for a similar example regarding
      // explicit error handling
      print('an error occured while creating an undo snapshot: $err');
      await Sentry.captureException(err, stackTrace: stackTrace);
    }

    _isCreatingSnapshot = false;

    notifyListeners();
  }

  /// Resets the undo/reset stack.
  /// Doesn't perform any cleanup of the old stack in the database - this
  /// is performed as part of every call to "createSnapshot".
  void clearAllSnapshots() {
    _currentSnapshotVersion = 0;
    _maxSnapshotVersion = 0;

    notifyListeners();
  }

  @override
  void persist(Batch batch) {
    UndoRedoStatePersistor.persist(batch, this);
  }

  @override
  Future<void> rehydrate(Database db, BuildContext context) async {
    var result = await UndoRedoStatePersistor.rehydrate(db);

    _currentSnapshotVersion = result.currentSnapshotVersion;
    _maxSnapshotVersion = result.maxSnapshotVersion;
  }
}
