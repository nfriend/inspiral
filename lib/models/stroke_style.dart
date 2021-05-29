import 'package:inspiral/database/schema.dart';

enum StrokeStyle { normal, airbrush }

/// Converts a `StrokeStyle` enum value into a `String` that can be
/// saved in the database.
String strokeStyleToString(StrokeStyle/*!*/ style) {
  return style == StrokeStyle.normal
      ? StrokeStyleType.normal
      : StrokeStyleType.airbrush;
}

/// The opposite of `strokeStyleToString()`
StrokeStyle stringToStrokeStyle(String/*!*/ style) {
  assert(StrokeStyleType.all.contains(style),
      '"$style" is not a valid stroke style type. Valid values are: [${StrokeStyleType.all.join(',')}]');

  return style == StrokeStyleType.normal
      ? StrokeStyle.normal
      : StrokeStyle.airbrush;
}
