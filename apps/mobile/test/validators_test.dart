import 'package:flutter_test/flutter_test.dart';
import 'package:gatherly/utils/validators.dart';

void main() {
  group('validateEmail', () {
    test('accepts a normal address', () {
      expect(validateEmail('thabo@example.com'), isNull);
      expect(validateEmail('  thabo@example.com  '), isNull);
    });

    test('rejects empty and malformed addresses', () {
      expect(validateEmail(''), 'Enter your email.');
      expect(validateEmail('thabo'), isNotNull);
      expect(validateEmail('thabo@example'), isNotNull);
      expect(validateEmail('thabo @example.com'), isNotNull);
    });
  });

  group('validateNewPassword', () {
    test('needs 8 characters and a number', () {
      expect(validateNewPassword('short1'), 'Use at least 8 characters.');
      expect(validateNewPassword('nonumbers'), 'Add at least one number.');
      expect(validateNewPassword('gatherly1'), isNull);
    });
  });

  group('parseDate', () {
    test('reads DD/MM/YYYY with or without spaces', () {
      expect(parseDate('05/03/2000'), DateTime(2000, 3, 5));
      expect(parseDate('5 / 3 / 2000'), DateTime(2000, 3, 5));
    });

    test('rejects dates that do not exist or are in the future', () {
      expect(parseDate('31/02/2000'), isNull);
      expect(parseDate('2000-03-05'), isNull);
      expect(parseDate('01/01/2999'), isNull);
    });
  });

  group('isAdult', () {
    final today = DateTime(2026, 11, 12);

    test('is true on and after the 18th birthday', () {
      expect(isAdult(DateTime(2008, 11, 12), today: today), isTrue);
      expect(isAdult(DateTime(1999, 1, 1), today: today), isTrue);
    });

    test('is false the day before the 18th birthday', () {
      expect(isAdult(DateTime(2008, 11, 13), today: today), isFalse);
    });
  });
}
