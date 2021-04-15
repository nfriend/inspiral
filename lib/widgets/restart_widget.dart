import 'package:flutter/material.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/util/delete_database.dart';

/// Allows the app the be "restarted" by triggering a rebuild
/// at its very top-level component.
/// Based on https://stackoverflow.com/a/50116077/1063392
class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  /// "Restarts" the app by triggering a rebuild at the root.
  /// Pass `resetDb = true` to delete the database before restarting,
  /// effectively reseting the app to factory state (except for
  /// purchases, which aren't stored in the database).
  static Future<void> restartApp(BuildContext context,
      {bool resetDb = false}) async {
    if (resetDb) {
      var db = await getDatabase();
      await db.close();
      await deleteDatabase();
    }

    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
