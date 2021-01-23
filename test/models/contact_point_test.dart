import 'dart:math';
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
            ContactPoint(position: Offset(3, 6), direction: pi / 2);
        ContactPoint point2 =
            ContactPoint(position: Offset(9, 18), direction: pi);

        ContactPoint expected =
            ContactPoint(position: Offset(7, 14), direction: atan2(1, -2));

        expect(
            ContactPoint.weightedAverage([
              Tuple2<ContactPoint, double>(point1, 1),
              Tuple2<ContactPoint, double>(point2, 2)
            ]),
            expected);
      });

      test(
          'returns the correct direction when the two directions are offset by 2*pi',
          () {
        ContactPoint point1 = ContactPoint(position: Offset.zero, direction: 1);
        ContactPoint point2 =
            ContactPoint(position: Offset.zero, direction: 2 * pi - 1);

        ContactPoint actual = ContactPoint.weightedAverage([
          Tuple2<ContactPoint, double>(point1, 1),
          Tuple2<ContactPoint, double>(point2, 1)
        ]);

        double epsilon = 0.000001;
        bool isInRange =
            actual.direction > -epsilon && actual.direction < epsilon;
        expect(isInRange, true);
      });
    });
  });
}
