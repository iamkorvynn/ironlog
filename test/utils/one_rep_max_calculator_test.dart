import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/utils/one_rep_max_calculator.dart';

void main() {
  group('OneRepMaxCalculator - boundary checks', () {
    test('0 weight returns 0', () => expect(OneRepMaxCalculator.epley(0, 5), 0.0));
    test('0 reps returns 0', () => expect(OneRepMaxCalculator.epley(100, 0), 0.0));
    test('negative weight returns 0', () => expect(OneRepMaxCalculator.epley(-50, 5), 0.0));
    test('negative reps returns 0', () => expect(OneRepMaxCalculator.epley(100, -2), 0.0));
  });

  group('OneRepMaxCalculator - parameterized 1RM matrix', () {
    test('calculates 1RM for 40kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(40.0, 1);
      final b = OneRepMaxCalculator.brzycki(40.0, 1);
      expect(e, greaterThanOrEqualTo(40.0));
      expect(b, greaterThanOrEqualTo(40.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(40.0, 0.01));
    });
    test('calculates 1RM for 40kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(40.0, 2);
      final b = OneRepMaxCalculator.brzycki(40.0, 2);
      expect(e, greaterThanOrEqualTo(40.0));
      expect(b, greaterThanOrEqualTo(40.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(40.0, 0.01));
    });
    test('calculates 1RM for 40kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(40.0, 3);
      final b = OneRepMaxCalculator.brzycki(40.0, 3);
      expect(e, greaterThanOrEqualTo(40.0));
      expect(b, greaterThanOrEqualTo(40.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(40.0, 0.01));
    });
    test('calculates 1RM for 40kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(40.0, 4);
      final b = OneRepMaxCalculator.brzycki(40.0, 4);
      expect(e, greaterThanOrEqualTo(40.0));
      expect(b, greaterThanOrEqualTo(40.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(40.0, 0.01));
    });
    test('calculates 1RM for 40kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(40.0, 5);
      final b = OneRepMaxCalculator.brzycki(40.0, 5);
      expect(e, greaterThanOrEqualTo(40.0));
      expect(b, greaterThanOrEqualTo(40.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(40.0, 0.01));
    });
    test('calculates 1RM for 40kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(40.0, 6);
      final b = OneRepMaxCalculator.brzycki(40.0, 6);
      expect(e, greaterThanOrEqualTo(40.0));
      expect(b, greaterThanOrEqualTo(40.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(40.0, 0.01));
    });
    test('calculates 1RM for 40kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(40.0, 7);
      final b = OneRepMaxCalculator.brzycki(40.0, 7);
      expect(e, greaterThanOrEqualTo(40.0));
      expect(b, greaterThanOrEqualTo(40.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(40.0, 0.01));
    });
    test('calculates 1RM for 40kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(40.0, 8);
      final b = OneRepMaxCalculator.brzycki(40.0, 8);
      expect(e, greaterThanOrEqualTo(40.0));
      expect(b, greaterThanOrEqualTo(40.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(40.0, 0.01));
    });
    test('calculates 1RM for 40kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(40.0, 9);
      final b = OneRepMaxCalculator.brzycki(40.0, 9);
      expect(e, greaterThanOrEqualTo(40.0));
      expect(b, greaterThanOrEqualTo(40.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(40.0, 0.01));
    });
    test('calculates 1RM for 40kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(40.0, 10);
      final b = OneRepMaxCalculator.brzycki(40.0, 10);
      expect(e, greaterThanOrEqualTo(40.0));
      expect(b, greaterThanOrEqualTo(40.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(40.0, 0.01));
    });
    test('calculates 1RM for 40kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(40.0, 11);
      final b = OneRepMaxCalculator.brzycki(40.0, 11);
      expect(e, greaterThanOrEqualTo(40.0));
      expect(b, greaterThanOrEqualTo(40.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(40.0, 0.01));
    });
    test('calculates 1RM for 40kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(40.0, 12);
      final b = OneRepMaxCalculator.brzycki(40.0, 12);
      expect(e, greaterThanOrEqualTo(40.0));
      expect(b, greaterThanOrEqualTo(40.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(40.0, 0.01));
    });
    test('calculates 1RM for 50kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(50.0, 1);
      final b = OneRepMaxCalculator.brzycki(50.0, 1);
      expect(e, greaterThanOrEqualTo(50.0));
      expect(b, greaterThanOrEqualTo(50.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(50.0, 0.01));
    });
    test('calculates 1RM for 50kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(50.0, 2);
      final b = OneRepMaxCalculator.brzycki(50.0, 2);
      expect(e, greaterThanOrEqualTo(50.0));
      expect(b, greaterThanOrEqualTo(50.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(50.0, 0.01));
    });
    test('calculates 1RM for 50kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(50.0, 3);
      final b = OneRepMaxCalculator.brzycki(50.0, 3);
      expect(e, greaterThanOrEqualTo(50.0));
      expect(b, greaterThanOrEqualTo(50.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(50.0, 0.01));
    });
    test('calculates 1RM for 50kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(50.0, 4);
      final b = OneRepMaxCalculator.brzycki(50.0, 4);
      expect(e, greaterThanOrEqualTo(50.0));
      expect(b, greaterThanOrEqualTo(50.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(50.0, 0.01));
    });
    test('calculates 1RM for 50kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(50.0, 5);
      final b = OneRepMaxCalculator.brzycki(50.0, 5);
      expect(e, greaterThanOrEqualTo(50.0));
      expect(b, greaterThanOrEqualTo(50.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(50.0, 0.01));
    });
    test('calculates 1RM for 50kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(50.0, 6);
      final b = OneRepMaxCalculator.brzycki(50.0, 6);
      expect(e, greaterThanOrEqualTo(50.0));
      expect(b, greaterThanOrEqualTo(50.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(50.0, 0.01));
    });
    test('calculates 1RM for 50kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(50.0, 7);
      final b = OneRepMaxCalculator.brzycki(50.0, 7);
      expect(e, greaterThanOrEqualTo(50.0));
      expect(b, greaterThanOrEqualTo(50.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(50.0, 0.01));
    });
    test('calculates 1RM for 50kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(50.0, 8);
      final b = OneRepMaxCalculator.brzycki(50.0, 8);
      expect(e, greaterThanOrEqualTo(50.0));
      expect(b, greaterThanOrEqualTo(50.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(50.0, 0.01));
    });
    test('calculates 1RM for 50kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(50.0, 9);
      final b = OneRepMaxCalculator.brzycki(50.0, 9);
      expect(e, greaterThanOrEqualTo(50.0));
      expect(b, greaterThanOrEqualTo(50.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(50.0, 0.01));
    });
    test('calculates 1RM for 50kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(50.0, 10);
      final b = OneRepMaxCalculator.brzycki(50.0, 10);
      expect(e, greaterThanOrEqualTo(50.0));
      expect(b, greaterThanOrEqualTo(50.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(50.0, 0.01));
    });
    test('calculates 1RM for 50kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(50.0, 11);
      final b = OneRepMaxCalculator.brzycki(50.0, 11);
      expect(e, greaterThanOrEqualTo(50.0));
      expect(b, greaterThanOrEqualTo(50.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(50.0, 0.01));
    });
    test('calculates 1RM for 50kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(50.0, 12);
      final b = OneRepMaxCalculator.brzycki(50.0, 12);
      expect(e, greaterThanOrEqualTo(50.0));
      expect(b, greaterThanOrEqualTo(50.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(50.0, 0.01));
    });
    test('calculates 1RM for 60kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(60.0, 1);
      final b = OneRepMaxCalculator.brzycki(60.0, 1);
      expect(e, greaterThanOrEqualTo(60.0));
      expect(b, greaterThanOrEqualTo(60.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(60.0, 0.01));
    });
    test('calculates 1RM for 60kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(60.0, 2);
      final b = OneRepMaxCalculator.brzycki(60.0, 2);
      expect(e, greaterThanOrEqualTo(60.0));
      expect(b, greaterThanOrEqualTo(60.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(60.0, 0.01));
    });
    test('calculates 1RM for 60kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(60.0, 3);
      final b = OneRepMaxCalculator.brzycki(60.0, 3);
      expect(e, greaterThanOrEqualTo(60.0));
      expect(b, greaterThanOrEqualTo(60.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(60.0, 0.01));
    });
    test('calculates 1RM for 60kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(60.0, 4);
      final b = OneRepMaxCalculator.brzycki(60.0, 4);
      expect(e, greaterThanOrEqualTo(60.0));
      expect(b, greaterThanOrEqualTo(60.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(60.0, 0.01));
    });
    test('calculates 1RM for 60kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(60.0, 5);
      final b = OneRepMaxCalculator.brzycki(60.0, 5);
      expect(e, greaterThanOrEqualTo(60.0));
      expect(b, greaterThanOrEqualTo(60.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(60.0, 0.01));
    });
    test('calculates 1RM for 60kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(60.0, 6);
      final b = OneRepMaxCalculator.brzycki(60.0, 6);
      expect(e, greaterThanOrEqualTo(60.0));
      expect(b, greaterThanOrEqualTo(60.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(60.0, 0.01));
    });
    test('calculates 1RM for 60kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(60.0, 7);
      final b = OneRepMaxCalculator.brzycki(60.0, 7);
      expect(e, greaterThanOrEqualTo(60.0));
      expect(b, greaterThanOrEqualTo(60.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(60.0, 0.01));
    });
    test('calculates 1RM for 60kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(60.0, 8);
      final b = OneRepMaxCalculator.brzycki(60.0, 8);
      expect(e, greaterThanOrEqualTo(60.0));
      expect(b, greaterThanOrEqualTo(60.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(60.0, 0.01));
    });
    test('calculates 1RM for 60kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(60.0, 9);
      final b = OneRepMaxCalculator.brzycki(60.0, 9);
      expect(e, greaterThanOrEqualTo(60.0));
      expect(b, greaterThanOrEqualTo(60.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(60.0, 0.01));
    });
    test('calculates 1RM for 60kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(60.0, 10);
      final b = OneRepMaxCalculator.brzycki(60.0, 10);
      expect(e, greaterThanOrEqualTo(60.0));
      expect(b, greaterThanOrEqualTo(60.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(60.0, 0.01));
    });
    test('calculates 1RM for 60kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(60.0, 11);
      final b = OneRepMaxCalculator.brzycki(60.0, 11);
      expect(e, greaterThanOrEqualTo(60.0));
      expect(b, greaterThanOrEqualTo(60.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(60.0, 0.01));
    });
    test('calculates 1RM for 60kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(60.0, 12);
      final b = OneRepMaxCalculator.brzycki(60.0, 12);
      expect(e, greaterThanOrEqualTo(60.0));
      expect(b, greaterThanOrEqualTo(60.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(60.0, 0.01));
    });
    test('calculates 1RM for 70kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(70.0, 1);
      final b = OneRepMaxCalculator.brzycki(70.0, 1);
      expect(e, greaterThanOrEqualTo(70.0));
      expect(b, greaterThanOrEqualTo(70.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(70.0, 0.01));
    });
    test('calculates 1RM for 70kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(70.0, 2);
      final b = OneRepMaxCalculator.brzycki(70.0, 2);
      expect(e, greaterThanOrEqualTo(70.0));
      expect(b, greaterThanOrEqualTo(70.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(70.0, 0.01));
    });
    test('calculates 1RM for 70kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(70.0, 3);
      final b = OneRepMaxCalculator.brzycki(70.0, 3);
      expect(e, greaterThanOrEqualTo(70.0));
      expect(b, greaterThanOrEqualTo(70.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(70.0, 0.01));
    });
    test('calculates 1RM for 70kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(70.0, 4);
      final b = OneRepMaxCalculator.brzycki(70.0, 4);
      expect(e, greaterThanOrEqualTo(70.0));
      expect(b, greaterThanOrEqualTo(70.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(70.0, 0.01));
    });
    test('calculates 1RM for 70kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(70.0, 5);
      final b = OneRepMaxCalculator.brzycki(70.0, 5);
      expect(e, greaterThanOrEqualTo(70.0));
      expect(b, greaterThanOrEqualTo(70.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(70.0, 0.01));
    });
    test('calculates 1RM for 70kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(70.0, 6);
      final b = OneRepMaxCalculator.brzycki(70.0, 6);
      expect(e, greaterThanOrEqualTo(70.0));
      expect(b, greaterThanOrEqualTo(70.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(70.0, 0.01));
    });
    test('calculates 1RM for 70kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(70.0, 7);
      final b = OneRepMaxCalculator.brzycki(70.0, 7);
      expect(e, greaterThanOrEqualTo(70.0));
      expect(b, greaterThanOrEqualTo(70.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(70.0, 0.01));
    });
    test('calculates 1RM for 70kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(70.0, 8);
      final b = OneRepMaxCalculator.brzycki(70.0, 8);
      expect(e, greaterThanOrEqualTo(70.0));
      expect(b, greaterThanOrEqualTo(70.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(70.0, 0.01));
    });
    test('calculates 1RM for 70kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(70.0, 9);
      final b = OneRepMaxCalculator.brzycki(70.0, 9);
      expect(e, greaterThanOrEqualTo(70.0));
      expect(b, greaterThanOrEqualTo(70.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(70.0, 0.01));
    });
    test('calculates 1RM for 70kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(70.0, 10);
      final b = OneRepMaxCalculator.brzycki(70.0, 10);
      expect(e, greaterThanOrEqualTo(70.0));
      expect(b, greaterThanOrEqualTo(70.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(70.0, 0.01));
    });
    test('calculates 1RM for 70kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(70.0, 11);
      final b = OneRepMaxCalculator.brzycki(70.0, 11);
      expect(e, greaterThanOrEqualTo(70.0));
      expect(b, greaterThanOrEqualTo(70.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(70.0, 0.01));
    });
    test('calculates 1RM for 70kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(70.0, 12);
      final b = OneRepMaxCalculator.brzycki(70.0, 12);
      expect(e, greaterThanOrEqualTo(70.0));
      expect(b, greaterThanOrEqualTo(70.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(70.0, 0.01));
    });
    test('calculates 1RM for 80kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(80.0, 1);
      final b = OneRepMaxCalculator.brzycki(80.0, 1);
      expect(e, greaterThanOrEqualTo(80.0));
      expect(b, greaterThanOrEqualTo(80.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(80.0, 0.01));
    });
    test('calculates 1RM for 80kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(80.0, 2);
      final b = OneRepMaxCalculator.brzycki(80.0, 2);
      expect(e, greaterThanOrEqualTo(80.0));
      expect(b, greaterThanOrEqualTo(80.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(80.0, 0.01));
    });
    test('calculates 1RM for 80kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(80.0, 3);
      final b = OneRepMaxCalculator.brzycki(80.0, 3);
      expect(e, greaterThanOrEqualTo(80.0));
      expect(b, greaterThanOrEqualTo(80.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(80.0, 0.01));
    });
    test('calculates 1RM for 80kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(80.0, 4);
      final b = OneRepMaxCalculator.brzycki(80.0, 4);
      expect(e, greaterThanOrEqualTo(80.0));
      expect(b, greaterThanOrEqualTo(80.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(80.0, 0.01));
    });
    test('calculates 1RM for 80kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(80.0, 5);
      final b = OneRepMaxCalculator.brzycki(80.0, 5);
      expect(e, greaterThanOrEqualTo(80.0));
      expect(b, greaterThanOrEqualTo(80.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(80.0, 0.01));
    });
    test('calculates 1RM for 80kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(80.0, 6);
      final b = OneRepMaxCalculator.brzycki(80.0, 6);
      expect(e, greaterThanOrEqualTo(80.0));
      expect(b, greaterThanOrEqualTo(80.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(80.0, 0.01));
    });
    test('calculates 1RM for 80kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(80.0, 7);
      final b = OneRepMaxCalculator.brzycki(80.0, 7);
      expect(e, greaterThanOrEqualTo(80.0));
      expect(b, greaterThanOrEqualTo(80.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(80.0, 0.01));
    });
    test('calculates 1RM for 80kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(80.0, 8);
      final b = OneRepMaxCalculator.brzycki(80.0, 8);
      expect(e, greaterThanOrEqualTo(80.0));
      expect(b, greaterThanOrEqualTo(80.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(80.0, 0.01));
    });
    test('calculates 1RM for 80kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(80.0, 9);
      final b = OneRepMaxCalculator.brzycki(80.0, 9);
      expect(e, greaterThanOrEqualTo(80.0));
      expect(b, greaterThanOrEqualTo(80.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(80.0, 0.01));
    });
    test('calculates 1RM for 80kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(80.0, 10);
      final b = OneRepMaxCalculator.brzycki(80.0, 10);
      expect(e, greaterThanOrEqualTo(80.0));
      expect(b, greaterThanOrEqualTo(80.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(80.0, 0.01));
    });
    test('calculates 1RM for 80kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(80.0, 11);
      final b = OneRepMaxCalculator.brzycki(80.0, 11);
      expect(e, greaterThanOrEqualTo(80.0));
      expect(b, greaterThanOrEqualTo(80.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(80.0, 0.01));
    });
    test('calculates 1RM for 80kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(80.0, 12);
      final b = OneRepMaxCalculator.brzycki(80.0, 12);
      expect(e, greaterThanOrEqualTo(80.0));
      expect(b, greaterThanOrEqualTo(80.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(80.0, 0.01));
    });
    test('calculates 1RM for 90kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(90.0, 1);
      final b = OneRepMaxCalculator.brzycki(90.0, 1);
      expect(e, greaterThanOrEqualTo(90.0));
      expect(b, greaterThanOrEqualTo(90.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(90.0, 0.01));
    });
    test('calculates 1RM for 90kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(90.0, 2);
      final b = OneRepMaxCalculator.brzycki(90.0, 2);
      expect(e, greaterThanOrEqualTo(90.0));
      expect(b, greaterThanOrEqualTo(90.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(90.0, 0.01));
    });
    test('calculates 1RM for 90kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(90.0, 3);
      final b = OneRepMaxCalculator.brzycki(90.0, 3);
      expect(e, greaterThanOrEqualTo(90.0));
      expect(b, greaterThanOrEqualTo(90.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(90.0, 0.01));
    });
    test('calculates 1RM for 90kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(90.0, 4);
      final b = OneRepMaxCalculator.brzycki(90.0, 4);
      expect(e, greaterThanOrEqualTo(90.0));
      expect(b, greaterThanOrEqualTo(90.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(90.0, 0.01));
    });
    test('calculates 1RM for 90kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(90.0, 5);
      final b = OneRepMaxCalculator.brzycki(90.0, 5);
      expect(e, greaterThanOrEqualTo(90.0));
      expect(b, greaterThanOrEqualTo(90.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(90.0, 0.01));
    });
    test('calculates 1RM for 90kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(90.0, 6);
      final b = OneRepMaxCalculator.brzycki(90.0, 6);
      expect(e, greaterThanOrEqualTo(90.0));
      expect(b, greaterThanOrEqualTo(90.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(90.0, 0.01));
    });
    test('calculates 1RM for 90kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(90.0, 7);
      final b = OneRepMaxCalculator.brzycki(90.0, 7);
      expect(e, greaterThanOrEqualTo(90.0));
      expect(b, greaterThanOrEqualTo(90.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(90.0, 0.01));
    });
    test('calculates 1RM for 90kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(90.0, 8);
      final b = OneRepMaxCalculator.brzycki(90.0, 8);
      expect(e, greaterThanOrEqualTo(90.0));
      expect(b, greaterThanOrEqualTo(90.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(90.0, 0.01));
    });
    test('calculates 1RM for 90kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(90.0, 9);
      final b = OneRepMaxCalculator.brzycki(90.0, 9);
      expect(e, greaterThanOrEqualTo(90.0));
      expect(b, greaterThanOrEqualTo(90.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(90.0, 0.01));
    });
    test('calculates 1RM for 90kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(90.0, 10);
      final b = OneRepMaxCalculator.brzycki(90.0, 10);
      expect(e, greaterThanOrEqualTo(90.0));
      expect(b, greaterThanOrEqualTo(90.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(90.0, 0.01));
    });
    test('calculates 1RM for 90kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(90.0, 11);
      final b = OneRepMaxCalculator.brzycki(90.0, 11);
      expect(e, greaterThanOrEqualTo(90.0));
      expect(b, greaterThanOrEqualTo(90.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(90.0, 0.01));
    });
    test('calculates 1RM for 90kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(90.0, 12);
      final b = OneRepMaxCalculator.brzycki(90.0, 12);
      expect(e, greaterThanOrEqualTo(90.0));
      expect(b, greaterThanOrEqualTo(90.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(90.0, 0.01));
    });
    test('calculates 1RM for 100kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(100.0, 1);
      final b = OneRepMaxCalculator.brzycki(100.0, 1);
      expect(e, greaterThanOrEqualTo(100.0));
      expect(b, greaterThanOrEqualTo(100.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(100.0, 0.01));
    });
    test('calculates 1RM for 100kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(100.0, 2);
      final b = OneRepMaxCalculator.brzycki(100.0, 2);
      expect(e, greaterThanOrEqualTo(100.0));
      expect(b, greaterThanOrEqualTo(100.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(100.0, 0.01));
    });
    test('calculates 1RM for 100kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(100.0, 3);
      final b = OneRepMaxCalculator.brzycki(100.0, 3);
      expect(e, greaterThanOrEqualTo(100.0));
      expect(b, greaterThanOrEqualTo(100.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(100.0, 0.01));
    });
    test('calculates 1RM for 100kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(100.0, 4);
      final b = OneRepMaxCalculator.brzycki(100.0, 4);
      expect(e, greaterThanOrEqualTo(100.0));
      expect(b, greaterThanOrEqualTo(100.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(100.0, 0.01));
    });
    test('calculates 1RM for 100kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(100.0, 5);
      final b = OneRepMaxCalculator.brzycki(100.0, 5);
      expect(e, greaterThanOrEqualTo(100.0));
      expect(b, greaterThanOrEqualTo(100.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(100.0, 0.01));
    });
    test('calculates 1RM for 100kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(100.0, 6);
      final b = OneRepMaxCalculator.brzycki(100.0, 6);
      expect(e, greaterThanOrEqualTo(100.0));
      expect(b, greaterThanOrEqualTo(100.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(100.0, 0.01));
    });
    test('calculates 1RM for 100kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(100.0, 7);
      final b = OneRepMaxCalculator.brzycki(100.0, 7);
      expect(e, greaterThanOrEqualTo(100.0));
      expect(b, greaterThanOrEqualTo(100.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(100.0, 0.01));
    });
    test('calculates 1RM for 100kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(100.0, 8);
      final b = OneRepMaxCalculator.brzycki(100.0, 8);
      expect(e, greaterThanOrEqualTo(100.0));
      expect(b, greaterThanOrEqualTo(100.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(100.0, 0.01));
    });
    test('calculates 1RM for 100kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(100.0, 9);
      final b = OneRepMaxCalculator.brzycki(100.0, 9);
      expect(e, greaterThanOrEqualTo(100.0));
      expect(b, greaterThanOrEqualTo(100.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(100.0, 0.01));
    });
    test('calculates 1RM for 100kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(100.0, 10);
      final b = OneRepMaxCalculator.brzycki(100.0, 10);
      expect(e, greaterThanOrEqualTo(100.0));
      expect(b, greaterThanOrEqualTo(100.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(100.0, 0.01));
    });
    test('calculates 1RM for 100kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(100.0, 11);
      final b = OneRepMaxCalculator.brzycki(100.0, 11);
      expect(e, greaterThanOrEqualTo(100.0));
      expect(b, greaterThanOrEqualTo(100.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(100.0, 0.01));
    });
    test('calculates 1RM for 100kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(100.0, 12);
      final b = OneRepMaxCalculator.brzycki(100.0, 12);
      expect(e, greaterThanOrEqualTo(100.0));
      expect(b, greaterThanOrEqualTo(100.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(100.0, 0.01));
    });
    test('calculates 1RM for 110kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(110.0, 1);
      final b = OneRepMaxCalculator.brzycki(110.0, 1);
      expect(e, greaterThanOrEqualTo(110.0));
      expect(b, greaterThanOrEqualTo(110.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(110.0, 0.01));
    });
    test('calculates 1RM for 110kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(110.0, 2);
      final b = OneRepMaxCalculator.brzycki(110.0, 2);
      expect(e, greaterThanOrEqualTo(110.0));
      expect(b, greaterThanOrEqualTo(110.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(110.0, 0.01));
    });
    test('calculates 1RM for 110kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(110.0, 3);
      final b = OneRepMaxCalculator.brzycki(110.0, 3);
      expect(e, greaterThanOrEqualTo(110.0));
      expect(b, greaterThanOrEqualTo(110.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(110.0, 0.01));
    });
    test('calculates 1RM for 110kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(110.0, 4);
      final b = OneRepMaxCalculator.brzycki(110.0, 4);
      expect(e, greaterThanOrEqualTo(110.0));
      expect(b, greaterThanOrEqualTo(110.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(110.0, 0.01));
    });
    test('calculates 1RM for 110kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(110.0, 5);
      final b = OneRepMaxCalculator.brzycki(110.0, 5);
      expect(e, greaterThanOrEqualTo(110.0));
      expect(b, greaterThanOrEqualTo(110.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(110.0, 0.01));
    });
    test('calculates 1RM for 110kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(110.0, 6);
      final b = OneRepMaxCalculator.brzycki(110.0, 6);
      expect(e, greaterThanOrEqualTo(110.0));
      expect(b, greaterThanOrEqualTo(110.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(110.0, 0.01));
    });
    test('calculates 1RM for 110kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(110.0, 7);
      final b = OneRepMaxCalculator.brzycki(110.0, 7);
      expect(e, greaterThanOrEqualTo(110.0));
      expect(b, greaterThanOrEqualTo(110.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(110.0, 0.01));
    });
    test('calculates 1RM for 110kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(110.0, 8);
      final b = OneRepMaxCalculator.brzycki(110.0, 8);
      expect(e, greaterThanOrEqualTo(110.0));
      expect(b, greaterThanOrEqualTo(110.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(110.0, 0.01));
    });
    test('calculates 1RM for 110kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(110.0, 9);
      final b = OneRepMaxCalculator.brzycki(110.0, 9);
      expect(e, greaterThanOrEqualTo(110.0));
      expect(b, greaterThanOrEqualTo(110.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(110.0, 0.01));
    });
    test('calculates 1RM for 110kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(110.0, 10);
      final b = OneRepMaxCalculator.brzycki(110.0, 10);
      expect(e, greaterThanOrEqualTo(110.0));
      expect(b, greaterThanOrEqualTo(110.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(110.0, 0.01));
    });
    test('calculates 1RM for 110kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(110.0, 11);
      final b = OneRepMaxCalculator.brzycki(110.0, 11);
      expect(e, greaterThanOrEqualTo(110.0));
      expect(b, greaterThanOrEqualTo(110.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(110.0, 0.01));
    });
    test('calculates 1RM for 110kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(110.0, 12);
      final b = OneRepMaxCalculator.brzycki(110.0, 12);
      expect(e, greaterThanOrEqualTo(110.0));
      expect(b, greaterThanOrEqualTo(110.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(110.0, 0.01));
    });
    test('calculates 1RM for 120kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(120.0, 1);
      final b = OneRepMaxCalculator.brzycki(120.0, 1);
      expect(e, greaterThanOrEqualTo(120.0));
      expect(b, greaterThanOrEqualTo(120.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(120.0, 0.01));
    });
    test('calculates 1RM for 120kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(120.0, 2);
      final b = OneRepMaxCalculator.brzycki(120.0, 2);
      expect(e, greaterThanOrEqualTo(120.0));
      expect(b, greaterThanOrEqualTo(120.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(120.0, 0.01));
    });
    test('calculates 1RM for 120kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(120.0, 3);
      final b = OneRepMaxCalculator.brzycki(120.0, 3);
      expect(e, greaterThanOrEqualTo(120.0));
      expect(b, greaterThanOrEqualTo(120.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(120.0, 0.01));
    });
    test('calculates 1RM for 120kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(120.0, 4);
      final b = OneRepMaxCalculator.brzycki(120.0, 4);
      expect(e, greaterThanOrEqualTo(120.0));
      expect(b, greaterThanOrEqualTo(120.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(120.0, 0.01));
    });
    test('calculates 1RM for 120kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(120.0, 5);
      final b = OneRepMaxCalculator.brzycki(120.0, 5);
      expect(e, greaterThanOrEqualTo(120.0));
      expect(b, greaterThanOrEqualTo(120.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(120.0, 0.01));
    });
    test('calculates 1RM for 120kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(120.0, 6);
      final b = OneRepMaxCalculator.brzycki(120.0, 6);
      expect(e, greaterThanOrEqualTo(120.0));
      expect(b, greaterThanOrEqualTo(120.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(120.0, 0.01));
    });
    test('calculates 1RM for 120kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(120.0, 7);
      final b = OneRepMaxCalculator.brzycki(120.0, 7);
      expect(e, greaterThanOrEqualTo(120.0));
      expect(b, greaterThanOrEqualTo(120.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(120.0, 0.01));
    });
    test('calculates 1RM for 120kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(120.0, 8);
      final b = OneRepMaxCalculator.brzycki(120.0, 8);
      expect(e, greaterThanOrEqualTo(120.0));
      expect(b, greaterThanOrEqualTo(120.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(120.0, 0.01));
    });
    test('calculates 1RM for 120kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(120.0, 9);
      final b = OneRepMaxCalculator.brzycki(120.0, 9);
      expect(e, greaterThanOrEqualTo(120.0));
      expect(b, greaterThanOrEqualTo(120.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(120.0, 0.01));
    });
    test('calculates 1RM for 120kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(120.0, 10);
      final b = OneRepMaxCalculator.brzycki(120.0, 10);
      expect(e, greaterThanOrEqualTo(120.0));
      expect(b, greaterThanOrEqualTo(120.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(120.0, 0.01));
    });
    test('calculates 1RM for 120kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(120.0, 11);
      final b = OneRepMaxCalculator.brzycki(120.0, 11);
      expect(e, greaterThanOrEqualTo(120.0));
      expect(b, greaterThanOrEqualTo(120.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(120.0, 0.01));
    });
    test('calculates 1RM for 120kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(120.0, 12);
      final b = OneRepMaxCalculator.brzycki(120.0, 12);
      expect(e, greaterThanOrEqualTo(120.0));
      expect(b, greaterThanOrEqualTo(120.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(120.0, 0.01));
    });
    test('calculates 1RM for 130kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(130.0, 1);
      final b = OneRepMaxCalculator.brzycki(130.0, 1);
      expect(e, greaterThanOrEqualTo(130.0));
      expect(b, greaterThanOrEqualTo(130.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(130.0, 0.01));
    });
    test('calculates 1RM for 130kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(130.0, 2);
      final b = OneRepMaxCalculator.brzycki(130.0, 2);
      expect(e, greaterThanOrEqualTo(130.0));
      expect(b, greaterThanOrEqualTo(130.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(130.0, 0.01));
    });
    test('calculates 1RM for 130kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(130.0, 3);
      final b = OneRepMaxCalculator.brzycki(130.0, 3);
      expect(e, greaterThanOrEqualTo(130.0));
      expect(b, greaterThanOrEqualTo(130.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(130.0, 0.01));
    });
    test('calculates 1RM for 130kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(130.0, 4);
      final b = OneRepMaxCalculator.brzycki(130.0, 4);
      expect(e, greaterThanOrEqualTo(130.0));
      expect(b, greaterThanOrEqualTo(130.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(130.0, 0.01));
    });
    test('calculates 1RM for 130kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(130.0, 5);
      final b = OneRepMaxCalculator.brzycki(130.0, 5);
      expect(e, greaterThanOrEqualTo(130.0));
      expect(b, greaterThanOrEqualTo(130.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(130.0, 0.01));
    });
    test('calculates 1RM for 130kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(130.0, 6);
      final b = OneRepMaxCalculator.brzycki(130.0, 6);
      expect(e, greaterThanOrEqualTo(130.0));
      expect(b, greaterThanOrEqualTo(130.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(130.0, 0.01));
    });
    test('calculates 1RM for 130kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(130.0, 7);
      final b = OneRepMaxCalculator.brzycki(130.0, 7);
      expect(e, greaterThanOrEqualTo(130.0));
      expect(b, greaterThanOrEqualTo(130.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(130.0, 0.01));
    });
    test('calculates 1RM for 130kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(130.0, 8);
      final b = OneRepMaxCalculator.brzycki(130.0, 8);
      expect(e, greaterThanOrEqualTo(130.0));
      expect(b, greaterThanOrEqualTo(130.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(130.0, 0.01));
    });
    test('calculates 1RM for 130kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(130.0, 9);
      final b = OneRepMaxCalculator.brzycki(130.0, 9);
      expect(e, greaterThanOrEqualTo(130.0));
      expect(b, greaterThanOrEqualTo(130.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(130.0, 0.01));
    });
    test('calculates 1RM for 130kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(130.0, 10);
      final b = OneRepMaxCalculator.brzycki(130.0, 10);
      expect(e, greaterThanOrEqualTo(130.0));
      expect(b, greaterThanOrEqualTo(130.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(130.0, 0.01));
    });
    test('calculates 1RM for 130kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(130.0, 11);
      final b = OneRepMaxCalculator.brzycki(130.0, 11);
      expect(e, greaterThanOrEqualTo(130.0));
      expect(b, greaterThanOrEqualTo(130.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(130.0, 0.01));
    });
    test('calculates 1RM for 130kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(130.0, 12);
      final b = OneRepMaxCalculator.brzycki(130.0, 12);
      expect(e, greaterThanOrEqualTo(130.0));
      expect(b, greaterThanOrEqualTo(130.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(130.0, 0.01));
    });
    test('calculates 1RM for 140kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(140.0, 1);
      final b = OneRepMaxCalculator.brzycki(140.0, 1);
      expect(e, greaterThanOrEqualTo(140.0));
      expect(b, greaterThanOrEqualTo(140.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(140.0, 0.01));
    });
    test('calculates 1RM for 140kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(140.0, 2);
      final b = OneRepMaxCalculator.brzycki(140.0, 2);
      expect(e, greaterThanOrEqualTo(140.0));
      expect(b, greaterThanOrEqualTo(140.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(140.0, 0.01));
    });
    test('calculates 1RM for 140kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(140.0, 3);
      final b = OneRepMaxCalculator.brzycki(140.0, 3);
      expect(e, greaterThanOrEqualTo(140.0));
      expect(b, greaterThanOrEqualTo(140.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(140.0, 0.01));
    });
    test('calculates 1RM for 140kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(140.0, 4);
      final b = OneRepMaxCalculator.brzycki(140.0, 4);
      expect(e, greaterThanOrEqualTo(140.0));
      expect(b, greaterThanOrEqualTo(140.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(140.0, 0.01));
    });
    test('calculates 1RM for 140kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(140.0, 5);
      final b = OneRepMaxCalculator.brzycki(140.0, 5);
      expect(e, greaterThanOrEqualTo(140.0));
      expect(b, greaterThanOrEqualTo(140.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(140.0, 0.01));
    });
    test('calculates 1RM for 140kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(140.0, 6);
      final b = OneRepMaxCalculator.brzycki(140.0, 6);
      expect(e, greaterThanOrEqualTo(140.0));
      expect(b, greaterThanOrEqualTo(140.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(140.0, 0.01));
    });
    test('calculates 1RM for 140kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(140.0, 7);
      final b = OneRepMaxCalculator.brzycki(140.0, 7);
      expect(e, greaterThanOrEqualTo(140.0));
      expect(b, greaterThanOrEqualTo(140.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(140.0, 0.01));
    });
    test('calculates 1RM for 140kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(140.0, 8);
      final b = OneRepMaxCalculator.brzycki(140.0, 8);
      expect(e, greaterThanOrEqualTo(140.0));
      expect(b, greaterThanOrEqualTo(140.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(140.0, 0.01));
    });
    test('calculates 1RM for 140kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(140.0, 9);
      final b = OneRepMaxCalculator.brzycki(140.0, 9);
      expect(e, greaterThanOrEqualTo(140.0));
      expect(b, greaterThanOrEqualTo(140.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(140.0, 0.01));
    });
    test('calculates 1RM for 140kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(140.0, 10);
      final b = OneRepMaxCalculator.brzycki(140.0, 10);
      expect(e, greaterThanOrEqualTo(140.0));
      expect(b, greaterThanOrEqualTo(140.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(140.0, 0.01));
    });
    test('calculates 1RM for 140kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(140.0, 11);
      final b = OneRepMaxCalculator.brzycki(140.0, 11);
      expect(e, greaterThanOrEqualTo(140.0));
      expect(b, greaterThanOrEqualTo(140.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(140.0, 0.01));
    });
    test('calculates 1RM for 140kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(140.0, 12);
      final b = OneRepMaxCalculator.brzycki(140.0, 12);
      expect(e, greaterThanOrEqualTo(140.0));
      expect(b, greaterThanOrEqualTo(140.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(140.0, 0.01));
    });
    test('calculates 1RM for 150kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(150.0, 1);
      final b = OneRepMaxCalculator.brzycki(150.0, 1);
      expect(e, greaterThanOrEqualTo(150.0));
      expect(b, greaterThanOrEqualTo(150.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(150.0, 0.01));
    });
    test('calculates 1RM for 150kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(150.0, 2);
      final b = OneRepMaxCalculator.brzycki(150.0, 2);
      expect(e, greaterThanOrEqualTo(150.0));
      expect(b, greaterThanOrEqualTo(150.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(150.0, 0.01));
    });
    test('calculates 1RM for 150kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(150.0, 3);
      final b = OneRepMaxCalculator.brzycki(150.0, 3);
      expect(e, greaterThanOrEqualTo(150.0));
      expect(b, greaterThanOrEqualTo(150.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(150.0, 0.01));
    });
    test('calculates 1RM for 150kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(150.0, 4);
      final b = OneRepMaxCalculator.brzycki(150.0, 4);
      expect(e, greaterThanOrEqualTo(150.0));
      expect(b, greaterThanOrEqualTo(150.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(150.0, 0.01));
    });
    test('calculates 1RM for 150kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(150.0, 5);
      final b = OneRepMaxCalculator.brzycki(150.0, 5);
      expect(e, greaterThanOrEqualTo(150.0));
      expect(b, greaterThanOrEqualTo(150.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(150.0, 0.01));
    });
    test('calculates 1RM for 150kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(150.0, 6);
      final b = OneRepMaxCalculator.brzycki(150.0, 6);
      expect(e, greaterThanOrEqualTo(150.0));
      expect(b, greaterThanOrEqualTo(150.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(150.0, 0.01));
    });
    test('calculates 1RM for 150kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(150.0, 7);
      final b = OneRepMaxCalculator.brzycki(150.0, 7);
      expect(e, greaterThanOrEqualTo(150.0));
      expect(b, greaterThanOrEqualTo(150.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(150.0, 0.01));
    });
    test('calculates 1RM for 150kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(150.0, 8);
      final b = OneRepMaxCalculator.brzycki(150.0, 8);
      expect(e, greaterThanOrEqualTo(150.0));
      expect(b, greaterThanOrEqualTo(150.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(150.0, 0.01));
    });
    test('calculates 1RM for 150kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(150.0, 9);
      final b = OneRepMaxCalculator.brzycki(150.0, 9);
      expect(e, greaterThanOrEqualTo(150.0));
      expect(b, greaterThanOrEqualTo(150.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(150.0, 0.01));
    });
    test('calculates 1RM for 150kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(150.0, 10);
      final b = OneRepMaxCalculator.brzycki(150.0, 10);
      expect(e, greaterThanOrEqualTo(150.0));
      expect(b, greaterThanOrEqualTo(150.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(150.0, 0.01));
    });
    test('calculates 1RM for 150kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(150.0, 11);
      final b = OneRepMaxCalculator.brzycki(150.0, 11);
      expect(e, greaterThanOrEqualTo(150.0));
      expect(b, greaterThanOrEqualTo(150.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(150.0, 0.01));
    });
    test('calculates 1RM for 150kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(150.0, 12);
      final b = OneRepMaxCalculator.brzycki(150.0, 12);
      expect(e, greaterThanOrEqualTo(150.0));
      expect(b, greaterThanOrEqualTo(150.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(150.0, 0.01));
    });
    test('calculates 1RM for 160kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(160.0, 1);
      final b = OneRepMaxCalculator.brzycki(160.0, 1);
      expect(e, greaterThanOrEqualTo(160.0));
      expect(b, greaterThanOrEqualTo(160.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(160.0, 0.01));
    });
    test('calculates 1RM for 160kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(160.0, 2);
      final b = OneRepMaxCalculator.brzycki(160.0, 2);
      expect(e, greaterThanOrEqualTo(160.0));
      expect(b, greaterThanOrEqualTo(160.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(160.0, 0.01));
    });
    test('calculates 1RM for 160kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(160.0, 3);
      final b = OneRepMaxCalculator.brzycki(160.0, 3);
      expect(e, greaterThanOrEqualTo(160.0));
      expect(b, greaterThanOrEqualTo(160.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(160.0, 0.01));
    });
    test('calculates 1RM for 160kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(160.0, 4);
      final b = OneRepMaxCalculator.brzycki(160.0, 4);
      expect(e, greaterThanOrEqualTo(160.0));
      expect(b, greaterThanOrEqualTo(160.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(160.0, 0.01));
    });
    test('calculates 1RM for 160kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(160.0, 5);
      final b = OneRepMaxCalculator.brzycki(160.0, 5);
      expect(e, greaterThanOrEqualTo(160.0));
      expect(b, greaterThanOrEqualTo(160.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(160.0, 0.01));
    });
    test('calculates 1RM for 160kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(160.0, 6);
      final b = OneRepMaxCalculator.brzycki(160.0, 6);
      expect(e, greaterThanOrEqualTo(160.0));
      expect(b, greaterThanOrEqualTo(160.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(160.0, 0.01));
    });
    test('calculates 1RM for 160kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(160.0, 7);
      final b = OneRepMaxCalculator.brzycki(160.0, 7);
      expect(e, greaterThanOrEqualTo(160.0));
      expect(b, greaterThanOrEqualTo(160.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(160.0, 0.01));
    });
    test('calculates 1RM for 160kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(160.0, 8);
      final b = OneRepMaxCalculator.brzycki(160.0, 8);
      expect(e, greaterThanOrEqualTo(160.0));
      expect(b, greaterThanOrEqualTo(160.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(160.0, 0.01));
    });
    test('calculates 1RM for 160kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(160.0, 9);
      final b = OneRepMaxCalculator.brzycki(160.0, 9);
      expect(e, greaterThanOrEqualTo(160.0));
      expect(b, greaterThanOrEqualTo(160.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(160.0, 0.01));
    });
    test('calculates 1RM for 160kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(160.0, 10);
      final b = OneRepMaxCalculator.brzycki(160.0, 10);
      expect(e, greaterThanOrEqualTo(160.0));
      expect(b, greaterThanOrEqualTo(160.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(160.0, 0.01));
    });
    test('calculates 1RM for 160kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(160.0, 11);
      final b = OneRepMaxCalculator.brzycki(160.0, 11);
      expect(e, greaterThanOrEqualTo(160.0));
      expect(b, greaterThanOrEqualTo(160.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(160.0, 0.01));
    });
    test('calculates 1RM for 160kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(160.0, 12);
      final b = OneRepMaxCalculator.brzycki(160.0, 12);
      expect(e, greaterThanOrEqualTo(160.0));
      expect(b, greaterThanOrEqualTo(160.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(160.0, 0.01));
    });
    test('calculates 1RM for 180kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(180.0, 1);
      final b = OneRepMaxCalculator.brzycki(180.0, 1);
      expect(e, greaterThanOrEqualTo(180.0));
      expect(b, greaterThanOrEqualTo(180.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(180.0, 0.01));
    });
    test('calculates 1RM for 180kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(180.0, 2);
      final b = OneRepMaxCalculator.brzycki(180.0, 2);
      expect(e, greaterThanOrEqualTo(180.0));
      expect(b, greaterThanOrEqualTo(180.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(180.0, 0.01));
    });
    test('calculates 1RM for 180kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(180.0, 3);
      final b = OneRepMaxCalculator.brzycki(180.0, 3);
      expect(e, greaterThanOrEqualTo(180.0));
      expect(b, greaterThanOrEqualTo(180.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(180.0, 0.01));
    });
    test('calculates 1RM for 180kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(180.0, 4);
      final b = OneRepMaxCalculator.brzycki(180.0, 4);
      expect(e, greaterThanOrEqualTo(180.0));
      expect(b, greaterThanOrEqualTo(180.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(180.0, 0.01));
    });
    test('calculates 1RM for 180kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(180.0, 5);
      final b = OneRepMaxCalculator.brzycki(180.0, 5);
      expect(e, greaterThanOrEqualTo(180.0));
      expect(b, greaterThanOrEqualTo(180.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(180.0, 0.01));
    });
    test('calculates 1RM for 180kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(180.0, 6);
      final b = OneRepMaxCalculator.brzycki(180.0, 6);
      expect(e, greaterThanOrEqualTo(180.0));
      expect(b, greaterThanOrEqualTo(180.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(180.0, 0.01));
    });
    test('calculates 1RM for 180kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(180.0, 7);
      final b = OneRepMaxCalculator.brzycki(180.0, 7);
      expect(e, greaterThanOrEqualTo(180.0));
      expect(b, greaterThanOrEqualTo(180.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(180.0, 0.01));
    });
    test('calculates 1RM for 180kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(180.0, 8);
      final b = OneRepMaxCalculator.brzycki(180.0, 8);
      expect(e, greaterThanOrEqualTo(180.0));
      expect(b, greaterThanOrEqualTo(180.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(180.0, 0.01));
    });
    test('calculates 1RM for 180kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(180.0, 9);
      final b = OneRepMaxCalculator.brzycki(180.0, 9);
      expect(e, greaterThanOrEqualTo(180.0));
      expect(b, greaterThanOrEqualTo(180.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(180.0, 0.01));
    });
    test('calculates 1RM for 180kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(180.0, 10);
      final b = OneRepMaxCalculator.brzycki(180.0, 10);
      expect(e, greaterThanOrEqualTo(180.0));
      expect(b, greaterThanOrEqualTo(180.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(180.0, 0.01));
    });
    test('calculates 1RM for 180kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(180.0, 11);
      final b = OneRepMaxCalculator.brzycki(180.0, 11);
      expect(e, greaterThanOrEqualTo(180.0));
      expect(b, greaterThanOrEqualTo(180.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(180.0, 0.01));
    });
    test('calculates 1RM for 180kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(180.0, 12);
      final b = OneRepMaxCalculator.brzycki(180.0, 12);
      expect(e, greaterThanOrEqualTo(180.0));
      expect(b, greaterThanOrEqualTo(180.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(180.0, 0.01));
    });
    test('calculates 1RM for 200kg x 1 reps', () {
      final e = OneRepMaxCalculator.epley(200.0, 1);
      final b = OneRepMaxCalculator.brzycki(200.0, 1);
      expect(e, greaterThanOrEqualTo(200.0));
      expect(b, greaterThanOrEqualTo(200.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 1);
      expect(rev, closeTo(200.0, 0.01));
    });
    test('calculates 1RM for 200kg x 2 reps', () {
      final e = OneRepMaxCalculator.epley(200.0, 2);
      final b = OneRepMaxCalculator.brzycki(200.0, 2);
      expect(e, greaterThanOrEqualTo(200.0));
      expect(b, greaterThanOrEqualTo(200.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 2);
      expect(rev, closeTo(200.0, 0.01));
    });
    test('calculates 1RM for 200kg x 3 reps', () {
      final e = OneRepMaxCalculator.epley(200.0, 3);
      final b = OneRepMaxCalculator.brzycki(200.0, 3);
      expect(e, greaterThanOrEqualTo(200.0));
      expect(b, greaterThanOrEqualTo(200.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 3);
      expect(rev, closeTo(200.0, 0.01));
    });
    test('calculates 1RM for 200kg x 4 reps', () {
      final e = OneRepMaxCalculator.epley(200.0, 4);
      final b = OneRepMaxCalculator.brzycki(200.0, 4);
      expect(e, greaterThanOrEqualTo(200.0));
      expect(b, greaterThanOrEqualTo(200.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 4);
      expect(rev, closeTo(200.0, 0.01));
    });
    test('calculates 1RM for 200kg x 5 reps', () {
      final e = OneRepMaxCalculator.epley(200.0, 5);
      final b = OneRepMaxCalculator.brzycki(200.0, 5);
      expect(e, greaterThanOrEqualTo(200.0));
      expect(b, greaterThanOrEqualTo(200.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 5);
      expect(rev, closeTo(200.0, 0.01));
    });
    test('calculates 1RM for 200kg x 6 reps', () {
      final e = OneRepMaxCalculator.epley(200.0, 6);
      final b = OneRepMaxCalculator.brzycki(200.0, 6);
      expect(e, greaterThanOrEqualTo(200.0));
      expect(b, greaterThanOrEqualTo(200.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 6);
      expect(rev, closeTo(200.0, 0.01));
    });
    test('calculates 1RM for 200kg x 7 reps', () {
      final e = OneRepMaxCalculator.epley(200.0, 7);
      final b = OneRepMaxCalculator.brzycki(200.0, 7);
      expect(e, greaterThanOrEqualTo(200.0));
      expect(b, greaterThanOrEqualTo(200.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 7);
      expect(rev, closeTo(200.0, 0.01));
    });
    test('calculates 1RM for 200kg x 8 reps', () {
      final e = OneRepMaxCalculator.epley(200.0, 8);
      final b = OneRepMaxCalculator.brzycki(200.0, 8);
      expect(e, greaterThanOrEqualTo(200.0));
      expect(b, greaterThanOrEqualTo(200.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 8);
      expect(rev, closeTo(200.0, 0.01));
    });
    test('calculates 1RM for 200kg x 9 reps', () {
      final e = OneRepMaxCalculator.epley(200.0, 9);
      final b = OneRepMaxCalculator.brzycki(200.0, 9);
      expect(e, greaterThanOrEqualTo(200.0));
      expect(b, greaterThanOrEqualTo(200.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 9);
      expect(rev, closeTo(200.0, 0.01));
    });
    test('calculates 1RM for 200kg x 10 reps', () {
      final e = OneRepMaxCalculator.epley(200.0, 10);
      final b = OneRepMaxCalculator.brzycki(200.0, 10);
      expect(e, greaterThanOrEqualTo(200.0));
      expect(b, greaterThanOrEqualTo(200.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 10);
      expect(rev, closeTo(200.0, 0.01));
    });
    test('calculates 1RM for 200kg x 11 reps', () {
      final e = OneRepMaxCalculator.epley(200.0, 11);
      final b = OneRepMaxCalculator.brzycki(200.0, 11);
      expect(e, greaterThanOrEqualTo(200.0));
      expect(b, greaterThanOrEqualTo(200.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 11);
      expect(rev, closeTo(200.0, 0.01));
    });
    test('calculates 1RM for 200kg x 12 reps', () {
      final e = OneRepMaxCalculator.epley(200.0, 12);
      final b = OneRepMaxCalculator.brzycki(200.0, 12);
      expect(e, greaterThanOrEqualTo(200.0));
      expect(b, greaterThanOrEqualTo(200.0));
      final rev = OneRepMaxCalculator.weightForReps(e, 12);
      expect(rev, closeTo(200.0, 0.01));
    });
  });
}