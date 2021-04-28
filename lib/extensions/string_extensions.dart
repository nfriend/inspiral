// From https://stackoverflow.com/a/29629114/1063392
extension StringExtensions on String {
  String capitalizeFirstLetter() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String capitalizeFirstLetterOfAllWords() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalizeFirstLetter())
      .join(' ');
}
