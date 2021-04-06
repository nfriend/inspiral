import 'package:sqflite/sqlite_api.dart';

abstract class Persistable {
  /// Persists this object to the database
  void persist(Batch batch) {}

  /// Rehydrates this object from the database
  Future<void> rehydrate(Database database) async {}
}
