import 'package:flutter/material.dart';
import 'package:inspiral/gear_test.dart';

void main() {
  runApp(InspiralApp());
}

class InspiralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Inspiral',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GearTest());
  }
}
