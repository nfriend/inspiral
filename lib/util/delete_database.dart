import 'package:inspiral/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

/// Deletes the local database file
Future<void> deleteDatabase() async {
  var databasePath = join(await sqflite.getDatabasesPath(), localDatabaseName);

  await sqflite.deleteDatabase(databasePath);
}
