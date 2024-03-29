# Inspiral

<a href="https://gitlab.com/nfriend/inspiral/pipelines/latest" target="_blank"><img src="https://gitlab.com/nfriend/inspiral/badges/main/pipeline.svg" alt="GitLab pipeline status"></a>

<a href="https://www.instagram.com/inspiral.nathanfriend.io/">
  <img src="./website/public/images/social-icons/instagram.svg" alt="Instagram logo" width="40">
</a>
<a href="https://www.facebook.com/inspiral.nathanfriend.io">
  <img src="./website/public/images/social-icons/facebook.svg" alt="Facebook logo" width="40">
</a>
<a href="https://twitter.com/inspiral_app">
  <img src="./website/public/images/social-icons/twitter.svg" alt="Twitter logo" width="40">
</a>
<a href="https://inspiral-app.tumblr.com/">
  <img src="./website/public/images/social-icons/tumblr.svg" alt="Tumblr logo" width="40">
</a>
<a href="https://gitlab.com/nfriend/inspiral">
  <img src="./website/public/images/social-icons/gitlab.svg" alt="GitLab logo" width="40">
</a>
<a href="mailto:nathanfriend.io">
  <img src="./website/public/images/social-icons/email.svg" alt="Email logo" width="40">
</a>

<br>

Relive your childhood in pixel-perfect bliss.
[inspiral.nathanfriend.io](https://inspiral.nathanfriend.io)

<img alt="A screenshot of Inspiral" src="website/public/images/og-image-short.jpg" />

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
[`sqflite`])(https://pub.dev/packages/sqflite) migrations. To create a new
migration:

1. Add the columns/tables you want to add to
   [`schema.dart`](lib/database/schema.dart).
1. Add a new migration file in
   [`lib/database/migrations/upgrades`](lib/database/migrations/upgrades). The
   file should be named `upgrade_vX_to_vX.dart` and export a function named
   `upgradeVXToVX` (replace the `X`'s with the appropriate versions).
1. Bump the `localDatabaseVersion` in [`lib/constants.dart`](lib/constants.dart)
1. In
   [`lib/database/on_database_upgrade.dart`](lib/database/on_database_upgrade.dart),
   import the migratino function and add it to the mapping of version number ->
   migration function
1. Add a new test for the migration in
   [`integration_test/database/migrations_test.dart`](integration_test/database/migrations_test.dart)
   (see below)

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

The minimum version of SQLite that needs to be supported is 3.7.11 (Android API
level 16 - Android 4.1, Jelly Bean). It's wise to run these tests on both the
newest and oldest supported devices, to make sure the SQLite code in this
project is compatible with all compatible OSs.

### Passing environment variables at build time

To pass an environment variable to the app at compile time, use `--dart-define`:

```sh
flutter run --dart-define=mySecret=ABCD1234
```

Environment variables are then referenced in the app using the
[`EnvironmentConfig](`lib/environment_config.dart`) class.

### Building a release

First, bump the version in [`pubspec.yaml`](pubspec.yaml).

Bump the _semantic version_ portion (`1.2.3`) according to the type of change
(i.e. major, minor, or patch).

Bump the _build number_ portion (`+13`) by one, regardless of the type of
change.

Then, run:

```sh
scripts/build_release.sh
```

#### Android

Upload the generated file (`build/app/outputs/bundle/release/app-release.aab`)
through the Google Play Console website.

#### iOS

Open the generated file (`build/ios/archive/Runner.xcarchive`) in Xcode.
Validate (optional) and then Distribute the app, uploading directly through App
Store Connect.

#### Creating a GitLab release

Releases are automatically created by [the pipeline](.gitlab-ci.yml) when a tag
is pushed to the repo. The content in
[`store_listing/whats-new.md`](store_listing/whats-new.md) is used as the
release's description.

So, to create a new release:

- Update the `store_listing/whats-new.md` with a description of what's changed
  in the release
- Commit this change
- `git tag vX.X.X`
- `git push --tags`
- `git push`

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

Android does not require this configuration.

## Attributions

- Icons made by [Freepik](https://www.freepik.com) from
  [www.flaticon.com](https://www.flaticon.com)
