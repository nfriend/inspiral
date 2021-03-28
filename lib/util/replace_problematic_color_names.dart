/// Replaces problematic color names with non-offensive alternatives.
/// The original list of colors can be found here:
/// https://github.com/rydmike/flex_color_picker/blob/122aaa30817652bbb9ac12ad7b0128386c34040a/lib/src/color_tools.dart#L908
String replaceProblematicColorNames(String name) {
  if (name == 'Flesh') {
    return 'Deep Peach';
  }

  return name;
}
