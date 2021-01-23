import 'dart:ui';

import 'package:test/test.dart';
import 'package:inspiral/models/contact_point.dart';
import 'package:tuple/tuple.dart';

void main() {
  group('ContactPoint', () {
    group('weightedAverage', () {
      test('returns the correct weighted average of all provided ContactPoints',
          () {
        ContactPoint point1 =
            ContactPoint(position: Offset(3, 6), direction: 6);
        ContactPoint point2 =
            ContactPoint(position: Offset(9, 18), direction: 9);

        ContactPoint expected =
            ContactPoint(position: Offset(7, 14), direction: 8);

        expect(
            ContactPoint.weightedAverage([
              Tuple2<ContactPoint, double>(point1, 1),
              Tuple2<ContactPoint, double>(point2, 2)
            ]),
            expected);
      });
    });
  });
}
