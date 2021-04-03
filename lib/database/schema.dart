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
}

class ColorsTableType {
  static String pen = 'pen';
  static String canvas = 'canvas';
}

class StateTable extends Table {
  const StateTable() : super(name: 'state');

  final String selectedPenColor = 'selectedPenColor';
  final String selectedCanvasColor = 'selectedCanvasColor';
}
