# Inspiral

<a href="https://gitlab.com/nfriend/inspiral/pipelines/latest" target="_blank"><img src="https://gitlab.com/nfriend/inspiral/badges/main/pipeline.svg" alt="GitLab pipeline status"></a>

<a href="https://www.instagram.com/inspiral.nathanfriend.io/">
  <img src="./landing-page/public/images/social-icons/instagram.svg" alt="Instagram logo" width="40">
</a>
<a href="https://www.facebook.com/inspiral.nathanfriend.io">
  <img src="./landing-page/public/images/social-icons/facebook.svg" alt="Facebook logo" width="40">
</a>
<a href="https://twitter.com/inspiral_app">
  <img src="./landing-page/public/images/social-icons/twitter.svg" alt="Twitter logo" width="40">
</a>
<a href="https://inspiral-app.tumblr.com/">
  <img src="./landing-page/public/images/social-icons/tumblr.svg" alt="Tumblr logo" width="40">
</a>
<a href="https://gitlab.com/nfriend/inspiral">
  <img src="./landing-page/public/images/social-icons/gitlab.svg" alt="GitLab logo" width="40">
</a>
<a href="mailto:nathanfriend.io">
  <img src="./landing-page/public/images/social-icons/email.svg" alt="Email logo" width="40">
</a>

<br>

Relive your childhood in pixel-perfect bliss.
[inspiral.nathanfriend.io](https://inspiral.nathanfriend.io)

<img alt="A screenshot of Inspiral" src="landing-page/public/images/og-image-short.jpg" />

## Developing

This app is built using [Flutter](https://flutter.dev/).

### A note about code quality

This is a nights & weekends side project. My guiding principle while building
this app is: **have fun** :smile:. As a result, there are some rough patches in
this code base that would require non-fun refactoring work that I simply haven't
prioritized. This is not representative of my professional work! A much more
representative example is [my list of open-source contributions to
GitLab](https://gitlab.com/gitlab-org/gitlab/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&author_username=nfriend).

### Running

```sh
flutter run
```

See the [Flutter
documentation](https://flutter.dev/docs/development/tools/devtools/cli) for more
information about running and debugging a Flutter application locally.

_Note:_ I've mostly been using the [VSCode
plugin](https://flutter.dev/docs/development/tools/devtools/vscode) to launch
and debug the app.

### Database migrations

Changing the structure of the save data must be managed through
[`sqflite`])(https://pub.dev/packages/sqflite) migrations. See [the
docs](https://github.com/tekartik/sqflite/blob/master/sqflite/doc/migration_example.md)
for an example of how to do this.

#### Database migration tests

Database migrations are covered by an [integration
test](integration_test/database/migrations_test.dart) that upgrades a test
database from version 0 all the way to the latest version. It makes sure no
errors occur while running some smoke tests along the way. When a new migration
is added, be sure to add a test case for the new migration, and seed the
database with semi-realistic data for each new version.

The test can be run like this:

```sh
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/database/migrations_test.dart \
  -d <device id here>
```

`<device id here>` can be found by running `flutter devices`.

### Building a release

First, bump the version in [`pubspec.yaml`](pubspec.yaml).

#### Android

```sh
flutter clean && flutter build appbundle
```

Upload the generated file (`build/app/outputs/bundle/release/app-release.aab`)
through the Google Play Console website.

#### iOS

Make sure to replace `ABCD1234` with the app's real Apple ID.

```sh
flutter clean && flutter build ipa --dart-define=appStoreId=ABCD1234
```

Then, open the generated file (`build/ios/archive/Runner.xcarchive`) in Xcode.
Validate (optional) and then Distribute the app, uploading directly through App
Store Connect.

### Generating gears

Gear are generated by the [`gear_generator/`](gear_generator/src/index.ts) Node
application. See the [README in that directory](gear_generator/README.md) for
more information about this process.

### Updating the launcher icon

This app uses
[`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons) to
manage the app's icon for both Android and iOS.

The plugin is configured in [`pubspec.yaml`](pubspec.yaml). To re-generate the
icons, run:

```sh
flutter pub run flutter_launcher_icons:main
```

### Toubleshooting

**The CI build is failing due a dependency problem, but locally, everything
works fine.**

Make sure the default `image` in [`.gitlab-ci.yml`](.gitlab-ci.yml) matches the
version of Flutter you are using locally:

```yml
default:
  image: cirrusci/flutter:2.1.0-12.1.pre
```

**The app store review link is not working in iOS.**

In order for the app store review link to work (in iOS), the `appStoreId`
environment variable must be set to the app's store ID.

Environment variables are passed at build-time using `--dart-define`:

```sh
flutter run --dart-define=appStoreId=ABCD1234
```

Android does not require this configuration.

## Attributions

- Icons made by [Freepik](https://www.freepik.com) from
  [www.flaticon.com](https://www.flaticon.com)
