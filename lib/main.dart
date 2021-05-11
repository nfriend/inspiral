import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inspiral/environment_config.dart';
import 'package:inspiral/inspiral_app.dart';
import 'package:inspiral/widgets/restart_widget.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://4533347562a94db1a09a0308e3bed4f0@o403829.ingest.sentry.io/5707774';

      // To define the `isProduction` environment variable, build or run with:
      // --dart-define=isProduction=true
      // See the README for an example.
      if (EnvironmentConfig.isProduction == 'true') {
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
