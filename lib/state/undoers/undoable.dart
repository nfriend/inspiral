import 'package:sqflite/sqlite_api.dart';

/// Describes a class that supports undo (and redo)
abstract class Undoable {
  /// Undoes the most recent activity, moving backwards one snapshot
  /// in the undo/redo stack.
  /// The `version` parameter is the target version (i.e.
  /// the version we should undo to).
  Future<void> undo(int/*!*/ version) async {}

  /// The opposite of undo
  Future<void> redo(int/*!*/ version) async {}

  /// Capture the current state as a snapshot for the provided version
  Future<void> snapshot(int version, Batch batch) async {}

  /// Throw away any data for versions equal to or greater than `version`.
  /// This is called whenever the end of the redo stack is rendered
  /// irrelevant. For example, when a user draws new lines after undoing.
  Future<void> cleanUpOldRedoSnapshots(int version, Batch batch) async {}
}
