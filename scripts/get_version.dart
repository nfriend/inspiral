#!/usr/bin/env dart

import 'package:yaml/yaml.dart';
import 'dart:io';

// Gets the version from pubspec.yaml
// Run this script from the root of this project, like this:
//
// dart scripts/get_version.dart
Future<void> main() async {
  var file = File('pubspec.yaml');
  var yamlText = await file.readAsString();
  var yaml = loadYaml(yamlText);
  print(yaml['version']);
}
