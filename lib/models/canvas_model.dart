import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class CanvasModel extends ChangeNotifier {
  CanvasModel({this.rotation, this.zoom});

  /// The current rotation of the canvas, in radians
  double rotation;

  /// The current zoom level
  double zoom;
}
