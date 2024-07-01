import 'package:fit_track/models/functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isDigitsOnly', () {
    test('returns true for a string that contains only digits', () {
      expect(isDigitsOnly('12345'), isTrue);
    });

    test('returns false for a string that contains letters and digits', () {
      expect(isDigitsOnly('1a2b3c'), isFalse);
    });

    test('returns false for a string that contains special characters', () {
      expect(isDigitsOnly('123!@#'), isFalse);
    });

    test('returns false for a string that contains spaces', () {
      expect(isDigitsOnly('123 456'), isFalse);
    });

    test('returns false for an empty string', () {
      expect(isDigitsOnly(''), isFalse);
    });

  });
}
