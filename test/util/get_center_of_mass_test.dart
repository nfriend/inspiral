import 'package:flutter_test/flutter_test.dart';
import 'package:inspiral/util/get_center_of_mass.dart';

void main() {
  group('get_center_of_mass', () {
    test('returns the correct weighted average of all provided ContactPoints',
        () {
      List<Offset> points = [
        Offset(1, 2),
        Offset(3, 4),
        Offset(5, 6),
        Offset(7, 8),
        Offset(9, 10),
      ];

      Offset expected = Offset(5, 6);

      expect(getCenterOfMass(points), expected);
    });
  });
}
