import 'package:flutter/material.dart';

/// Given a list of points, finds their collective center of mass
Offset getCenterOfMass(Iterable<Offset> points) {
  return points.fold<Offset>(
          Offset.zero, (previousValue, element) => previousValue + element) /
      points.length.toDouble();
}
