import 'package:inspiral/constants.dart';
import 'package:inspiral/extensions/string_extensions.dart';

/// Prepares the display name of an in-app purchase for presentation.
/// Specifically:
/// 1. Removes the name of the app at the end of the title (only applies
///    on Android)
/// 2. Enforces consistent capitalization
String prepareIAPTitle(String title) {
  // Remove the " (Inspiral)" suffix added by Google Play
  title = title.replaceFirst(RegExp(r'\s+\(' + appName + r'\)$'), '');

  // Capitalize the first letter of each word
  title = title.capitalizeFirstLetterOfAllWords();

  return title;
}
