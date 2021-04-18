# Inspiral

<a href="https://gitlab.com/nfriend/inspiral/pipelines/latest" target="_blank"><img src="https://gitlab.com/nfriend/inspiral/badges/main/pipeline.svg" alt="GitLab pipeline status"></a>

Relive your childhood in pixel-perfect bliss.
[nfriend.gitlab.io/inspiral](https://nfriend.gitlab.io/inspiral/)

<img alt="A screenshot of Inspiral" src="screenshot.png" height="840" />

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

### Generating gears

Gear are generated by the [`gear_generator/`](gear_generator/src/index.ts) Node
application. See the [README in that directory](gear_generator/README.md) for
more information about this process.

### Toubleshooting

**The CI build is failing due a dependency problem, but locally, everything
works fine.**

Make sure the default `image` in [`.gitlab-ci.yml`](.gitlab-ci.yml) matches the
version of Flutter you are using locally:

```yml
default:
  image: cirrusci/flutter:2.1.0-12.1.pre
```

## Attributions

- Icons made by [Freepik](https://www.freepik.com) from
  [www.flaticon.com](https://www.flaticon.com)
