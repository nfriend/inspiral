class EnvironmentConfig {
  // I originally thought this ID might be private, so I avoided checking it
  // into source control and instead passed it in at build time using
  // --dart-define. But now I see that it's the App Store URL,
  // so no need to keep this ID secret.
  static const appStoreId =
      '1558340425'; // String.fromEnvironment('appStoreId');
}
