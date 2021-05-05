import 'package:inspiral/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

/// Deletes the local database file
Future<void> deleteDatabase({String databaseName = localDatabaseName}) async {
  var databasePath = join(await sqflite.getDatabasesPath(), databaseName);

  await sqflite.deleteDatabase(databasePath);
}
