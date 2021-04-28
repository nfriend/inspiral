import 'package:flutter/material.dart';

@immutable
class Package {
  static const String free = 'io.nathanfriend.inspiral.free';
  static const String ovalgears = 'io.nathanfriend.inspiral.ovalgears';
  static const String trianglegears = 'io.nathanfriend.inspiral.trianglegears';
  static const String squaregears = 'io.nathanfriend.inspiral.squaregears';
  static const String pentagongears = 'io.nathanfriend.inspiral.pentagongears';
  static const String specialgears = 'io.nathanfriend.inspiral.specialgears';
  static const String airbrushpens = 'io.nathanfriend.inspiral.airbrushpens';
  static const String custompencolors =
      'io.nathanfriend.inspiral.custompencolors';
  static const String custombackgroundcolors =
      'io.nathanfriend.inspiral.custombackgroundcolors';
  static const String everything = 'io.nathanfriend.inspiral.everything';

  /// The order in which the packages should be displayed
  static const List<String> order = [
    free,
    ovalgears,
    trianglegears,
    squaregears,
    pentagongears,
    specialgears,
    custompencolors,
    custombackgroundcolors,
    airbrushpens,
    everything
  ];
}
