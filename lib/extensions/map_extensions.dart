extension MapExtensions on Map {
  /// Removes all entries from this Map
  void removeAll() {
    removeWhere((key, value) => true);
  }
}
