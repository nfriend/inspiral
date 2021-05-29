import 'dart:math';
import 'package:flutter/material.dart';

class ListItemPadding extends StatelessWidget {
  final Widget child;

  ListItemPadding({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: 4.0,
            bottom: 4.0,
            left: max(16.0, MediaQuery.of(context).padding.left),
            right: max(16.0, MediaQuery.of(context).padding.right)),
        child: child);
  }
}
