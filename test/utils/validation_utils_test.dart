import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/utils/validation_utils.dart';

void main() {
  group('ValidationUtils - validateExerciseName', () {
    test('rejects null or empty string', () {
      expect(ValidationUtils.validateExerciseName(null), isNotNull);
      expect(ValidationUtils.validateExerciseName(''), isNotNull);
      expect(ValidationUtils.validateExerciseName('   '), isNotNull);
    });

    test('rejects single character name', () {
      expect(ValidationUtils.validateExerciseName('A'), isNotNull);
    });

    test('accepts valid exercise name', () {
      expect(ValidationUtils.validateExerciseName('Bench Press'), isNull);
      expect(ValidationUtils.validateExerciseName('Squat'), isNull);
    });

    test('rejects excessively long name (>50 chars)', () {
      final longName = 'A' * 55;
      expect(ValidationUtils.validateExerciseName(longName), isNotNull);
    });
  });

  group('ValidationUtils - validateWeight', () {
    test('rejects null or empty', () {
      expect(ValidationUtils.validateWeight(null), isNotNull);
      expect(ValidationUtils.validateWeight(''), isNotNull);
    });

    test('rejects non-numeric string', () {
      expect(ValidationUtils.validateWeight('abc'), isNotNull);
    });

    test('rejects negative numbers', () {
      expect(ValidationUtils.validateWeight('-5'), isNotNull);
    });

    test('accepts 0 and positive numbers', () {
      expect(ValidationUtils.validateWeight('0'), isNull);
      expect(ValidationUtils.validateWeight('100'), isNull);
      expect(ValidationUtils.validateWeight('142.5'), isNull);
    });

    test('rejects unreasonable weight (>1000kg)', () {
      expect(ValidationUtils.validateWeight('1200'), isNotNull);
    });
  });

  group('ValidationUtils - validateReps', () {
    test('rejects null or empty', () {
      expect(ValidationUtils.validateReps(null), isNotNull);
      expect(ValidationUtils.validateReps(''), isNotNull);
    });

    test('rejects 0 or negative reps', () {
      expect(ValidationUtils.validateReps('0'), isNotNull);
      expect(ValidationUtils.validateReps('-1'), isNotNull);
    });

    test('accepts positive integer reps', () {
      expect(ValidationUtils.validateReps('1'), isNull);
      expect(ValidationUtils.validateReps('12'), isNull);
    });

    test('rejects reps exceeding 500', () {
      expect(ValidationUtils.validateReps('600'), isNotNull);
    });
  });
}
