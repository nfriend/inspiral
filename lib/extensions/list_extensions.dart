extension ListExtensions on List {
  /// Removes all items from this List
  void removeAll() {
    removeWhere((element) => true);
  }
}
