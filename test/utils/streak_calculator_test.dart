import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/models/workout.dart';
import 'package:ironlog/utils/streak_calculator.dart';

void main() {
  group('StreakCalculator', () {
    test('returns empty streak for empty list', () {
      final s = StreakCalculator.calculate([]);
      expect(s.totalWorkouts, 0);
      expect(s.currentWeeklyStreak, 0);
      expect(s.totalVolumeKg, 0.0);
    });

    test('calculates single workout today', () {
      final now = DateTime.now();
      final w = Workout(
        id: 'w1',
        name: 'Legs',
        startTime: now,
        totalVolumeKg: 5000,
      );
      final s = StreakCalculator.calculate([w]);
      expect(s.totalWorkouts, 1);
      expect(s.totalVolumeKg, 5000.0);
      expect(s.currentWeeklyStreak, 1);
      expect(s.currentDayStreak, 1);
    });

    test('accumulates total volume across multiple workouts', () {
      final now = DateTime.now();
      final workouts = [
        Workout(id: 'w1', name: 'W1', startTime: now, totalVolumeKg: 3000),
        Workout(
          id: 'w2',
          name: 'W2',
          startTime: now.subtract(const Duration(days: 2)),
          totalVolumeKg: 4500,
        ),
      ];
      final s = StreakCalculator.calculate(workouts);
      expect(s.totalWorkouts, 2);
      expect(s.totalVolumeKg, 7500.0);
    });

    test('calculates multi-week streak across consecutive weeks', () {
      final now = DateTime.now();
      final workouts = [
        Workout(id: 'w1', name: 'W1', startTime: now),
        Workout(
          id: 'w2',
          name: 'W2',
          startTime: now.subtract(const Duration(days: 7)),
        ),
        Workout(
          id: 'w3',
          name: 'W3',
          startTime: now.subtract(const Duration(days: 14)),
        ),
      ];
      final s = StreakCalculator.calculate(workouts);
      expect(s.currentWeeklyStreak, 3);
    });

    test('streak breaks when there is a 2-week gap', () {
      final now = DateTime.now();
      final workouts = [
        Workout(id: 'w1', name: 'W1', startTime: now),
        Workout(
          id: 'w2',
          name: 'W2',
          startTime: now.subtract(const Duration(days: 21)),
        ),
      ];
      final s = StreakCalculator.calculate(workouts);
      expect(s.currentWeeklyStreak, 1);
    });
  });
}


  group('StreakCalculator - boundary calendar checks', () {
    test('calculates correctly across month boundary', () {
      final w1 = Workout(id: 'w1', name: 'W1', startTime: DateTime(2026, 11, 1));
      final w2 = Workout(id: 'w2', name: 'W2', startTime: DateTime(2026, 10, 25));
      final streak = StreakCalculator.calculate([w1, w2]);
      expect(streak.totalWorkouts, 2);
    });
  });
