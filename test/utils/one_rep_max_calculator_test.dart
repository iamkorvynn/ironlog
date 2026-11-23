import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/utils/one_rep_max_calculator.dart';

void main() {
  group('OneRepMaxCalculator - Epley formula', () {
    test('returns 0 for non-positive weight or reps', () {
      expect(OneRepMaxCalculator.epley(0, 5), 0.0);
      expect(OneRepMaxCalculator.epley(100, 0), 0.0);
      expect(OneRepMaxCalculator.epley(-50, 5), 0.0);
      expect(OneRepMaxCalculator.epley(100, -2), 0.0);
    });

    test('returns exact weight for 1 rep', () {
      expect(OneRepMaxCalculator.epley(100, 1), 100.0);
      expect(OneRepMaxCalculator.epley(142.5, 1), 142.5);
    });

    test('calculates 100kg x 10 reps as ~133.33kg', () {
      expect(OneRepMaxCalculator.epley(100, 10), closeTo(133.33, 0.01));
    });

    test('calculates 60kg x 5 reps as 70kg', () {
      expect(OneRepMaxCalculator.epley(60, 5), closeTo(70.0, 0.01));
    });

    test('calculates 100kg x 30 reps as 200kg', () {
      expect(OneRepMaxCalculator.epley(100, 30), closeTo(200.0, 0.01));
    });

    test('strictly increases with reps for same weight', () {
      final rm5 = OneRepMaxCalculator.epley(100, 5);
      final rm6 = OneRepMaxCalculator.epley(100, 6);
      final rm8 = OneRepMaxCalculator.epley(100, 8);
      expect(rm6, greaterThan(rm5));
      expect(rm8, greaterThan(rm6));
    });

    test('strictly increases with weight for same reps', () {
      final rm80 = OneRepMaxCalculator.epley(80, 5);
      final rm90 = OneRepMaxCalculator.epley(90, 5);
      expect(rm90, greaterThan(rm80));
    });
  });

  group('OneRepMaxCalculator - Brzycki formula', () {
    test('returns 0 for non-positive inputs', () {
      expect(OneRepMaxCalculator.brzycki(0, 5), 0.0);
      expect(OneRepMaxCalculator.brzycki(100, 0), 0.0);
    });

    test('returns exact weight for 1 rep', () {
      expect(OneRepMaxCalculator.brzycki(100, 1), 100.0);
    });

    test('calculates 100kg x 10 reps correctly (100 * 36 / 27 = 133.33)', () {
      expect(OneRepMaxCalculator.brzycki(100, 10), closeTo(133.33, 0.01));
    });

    test('calculates 80kg x 5 reps (80 * 36 / 32 = 90kg)', () {
      expect(OneRepMaxCalculator.brzycki(80, 5), closeTo(90.0, 0.01));
    });

    test('handles boundary >= 37 reps safely without divide-by-zero', () {
      expect(OneRepMaxCalculator.brzycki(100, 37), isPositive);
      expect(OneRepMaxCalculator.brzycki(100, 50), isPositive);
    });
  });

  group('OneRepMaxCalculator - weightForReps', () {
    test('returns 0 for non-positive inputs', () {
      expect(OneRepMaxCalculator.weightForReps(0, 5), 0.0);
      expect(OneRepMaxCalculator.weightForReps(100, 0), 0.0);
    });

    test('returns full 1RM for 1 rep', () {
      expect(OneRepMaxCalculator.weightForReps(100, 1), 100.0);
    });

    test('inverts Epley accurately for 10 reps', () {
      const oneRm = 133.3333;
      final wt = OneRepMaxCalculator.weightForReps(oneRm, 10);
      expect(wt, closeTo(100.0, 0.05));
    });

    test('weight decreases as target reps increase', () {
      const oneRm = 100.0;
      final w3 = OneRepMaxCalculator.weightForReps(oneRm, 3);
      final w6 = OneRepMaxCalculator.weightForReps(oneRm, 6);
      final w10 = OneRepMaxCalculator.weightForReps(oneRm, 10);
      expect(w3, greaterThan(w6));
      expect(w6, greaterThan(w10));
    });
  });

  group('OneRepMaxCalculator - repTable', () {
    test('generates 12 entries from 1 to 12 reps', () {
      final table = OneRepMaxCalculator.repTable(100);
      expect(table.length, 12);
      expect(table.keys.first, 1);
      expect(table.keys.last, 12);
    });

    test('rep 1 equals 100% of 1RM', () {
      final table = OneRepMaxCalculator.repTable(150);
      expect(table[1], 150.0);
    });

    test('all values are strictly descending', () {
      final table = OneRepMaxCalculator.repTable(100);
      for (int i = 1; i < 12; i++) {
        expect(table[i]!, greaterThan(table[i + 1]!));
      }
    });
  });
}


  group('OneRepMaxCalculator - high reps', () {
    test('calculates 15 reps cleanly', () {
      expect(OneRepMaxCalculator.epley(100, 15), 150.0);
    });
    test('calculates 20 reps cleanly', () {
      expect(OneRepMaxCalculator.epley(100, 20), closeTo(166.67, 0.01));
    });
  });
