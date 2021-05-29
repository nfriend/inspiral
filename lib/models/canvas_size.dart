import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:quiver/core.dart';

class CanvasSizeAndName {
  /// The ID that uniquely identifies this size.
  /// Used for storing the selected size in the database.
  final String id;

  /// The size
  final Size size;

  /// The name of this size. Displayed to the user when selecting
  /// the desired canvas size.
  final String name;

  const CanvasSizeAndName(
      {required this.id, required this.size, required this.name});

  @override
  bool operator ==(Object other) =>
      other is CanvasSizeAndName &&
      other.id == id &&
      other.size == size &&
      other.name == name;

  @override
  int get hashCode => hash3(id, size, name);
}

class CanvasSize {
  static const CanvasSizeAndName small = CanvasSizeAndName(
      id: 'small',
      size: Size(500 * scaleFactor, 500 * scaleFactor),
      name: 'Small');
  static const CanvasSizeAndName medium = CanvasSizeAndName(
      id: 'medium',
      size: Size(750 * scaleFactor, 750 * scaleFactor),
      name: 'Medium');
  static const CanvasSizeAndName large = CanvasSizeAndName(
      id: 'large',
      size: Size(1000 * scaleFactor, 1000 * scaleFactor),
      name: 'Large');

  static const List<CanvasSizeAndName> all = [
    CanvasSize.small,
    CanvasSize.medium,
    CanvasSize.large
  ];
}
