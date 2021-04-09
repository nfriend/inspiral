import 'package:flutter/material.dart';

// This file provides some basic type safety for table and column names

class Schema {
  static const ColorsTable colors = ColorsTable();
  static const StateTable state = StateTable();
}

class Table {
  final String name;

  const Table({@required this.name});

  @override
  String toString() => name;
}

class ColorsTable extends Table {
  const ColorsTable() : super(name: 'colors');

  final String id = 'id';
  final String value = 'value';
  final String type = 'type';
  final String order = 'order';
}

class ColorsTableType {
  static String pen = 'pen';
  static String canvas = 'canvas';
  static String lastSelectedPen = 'lastSelectedPen';
  static String lastSelectedCanvas = 'lastSelectedCanvas';

  static Iterable<String> all = [
    ColorsTableType.pen,
    ColorsTableType.canvas,
    ColorsTableType.lastSelectedPen,
    ColorsTableType.lastSelectedCanvas
  ];
}

class StateTable extends Table {
  const StateTable() : super(name: 'state');

  final String selectedPenColor = 'selectedPenColor';
  final String selectedCanvasColor = 'selectedCanvasColor';
  final String lastSelectedPenColor = 'lastSelectedPenColor';
  final String lastSelectedCanvasColor = 'lastSelectedCanvasColor';
  final String includeBackgroundWhenSaving = 'includeBackgroundWhenSaving';
  final String closeDrawingToolsDrawerOnDrag = 'closeDrawingToolsDrawerOnDrag';
  final String rotatingGearAngle = 'rotatingGearAngle';
  final String rotatingGearDefinitionId = 'rotatingGearDefinitionId';
  final String rotatingGearActiveHoleName = 'rotatingGearActiveHoleName';
  final String gearsAreVisible = 'gearsAreVisible';
  final String fixedGearPositionX = 'fixedGearPositionX';
  final String fixedGearPositionY = 'fixedGearPositionY';
  final String fixedGearDefinitionId = 'fixedGearDefinitionId';
  final String canvasTransform_0 = 'canvasTransform_0';
  final String canvasTransform_1 = 'canvasTransform_1';
  final String canvasTransform_2 = 'canvasTransform_2';
  final String canvasTransform_3 = 'canvasTransform_3';
  final String canvasTransform_4 = 'canvasTransform_4';
  final String canvasTransform_5 = 'canvasTransform_5';
  final String canvasTransform_6 = 'canvasTransform_6';
  final String canvasTransform_7 = 'canvasTransform_7';
  final String canvasTransform_8 = 'canvasTransform_8';
  final String canvasTransform_9 = 'canvasTransform_9';
  final String canvasTransform_10 = 'canvasTransform_10';
  final String canvasTransform_11 = 'canvasTransform_11';
  final String canvasTransform_12 = 'canvasTransform_12';
  final String canvasTransform_13 = 'canvasTransform_13';
  final String canvasTransform_14 = 'canvasTransform_14';
  final String canvasTransform_15 = 'canvasTransform_15';
}
