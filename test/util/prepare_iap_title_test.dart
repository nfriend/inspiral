import 'package:flutter_test/flutter_test.dart';
import 'package:inspiral/util/prepare_iap_title.dart';
import 'package:tuple/tuple.dart';

void main() {
  group('prepare_iap_title', () {
    test('prepares an in-app purchase title for display', () {
      var testCases = [
        Tuple2('Circle gears (Inspiral)', 'Circle Gears'),
        Tuple2('Circle gears', 'Circle Gears'),
        Tuple2('circle gears', 'Circle Gears'),
        Tuple2('Circle Gears', 'Circle Gears'),
      ];

      for (var testCase in testCases) {
        expect(prepareIAPTitle(testCase.item1), testCase.item2);
      }
    });
  });
}
