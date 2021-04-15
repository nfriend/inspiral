import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/inspiral_app.dart';
import 'package:inspiral/widgets/restart_widget.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://4533347562a94db1a09a0308e3bed4f0@o403829.ingest.sentry.io/5707774';

      // See https://stackoverflow.com/a/61725261/1063392 for instructions
      // on building this app with the `IS_PRODUCTION` var defined.
      if (String.fromEnvironment('IS_PRODUCTION', defaultValue: '') != '') {
        options.environment = 'production';
      } else if (kReleaseMode) {
        options.environment = 'release';
      } else if (kProfileMode) {
        options.environment = 'profile';
      } else {
        options.environment = 'debug';
      }
    },
    appRunner: () => runApp(RestartWidget(child: InspiralApp())),
  );
}
