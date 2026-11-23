import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/models/workout.dart';
import 'package:ironlog/utils/rest_day_advisor.dart';

void main() {
  group('RestDayAdvisor - getAdvice', () {
    test('returns welcome suggestion when no workouts exist', () {
      final advice = RestDayAdvisor.getAdvice([]);
      expect(advice, contains('Welcome to IronLog'));
    });

    test('returns post-workout advice when trained today', () {
      final now = DateTime.now();
      final w = Workout(
        id: 'w1',
        name: 'Upper Body',
        startTime: now,
      );
      final advice = RestDayAdvisor.getAdvice([w]);
      expect(advice, contains('today'));
    });

    test('warns when high frequency this week', () {
      final now = DateTime.now();
      final workouts = [
        Workout(id: 'w1', name: 'W1', startTime: now),
        Workout(id: 'w2', name: 'W2', startTime: now.subtract(const Duration(days: 1))),
        Workout(id: 'w3', name: 'W3', startTime: now.subtract(const Duration(days: 2))),
        Workout(id: 'w4', name: 'W4', startTime: now.subtract(const Duration(days: 3))),
      ];
      final advice = RestDayAdvisor.getAdvice(workouts);
      expect(advice.toLowerCase(), contains('rest'));
    });

    test('encourages training when rested 1 day and low frequency', () {
      final now = DateTime.now();
      final workouts = [
        Workout(
          id: 'w1',
          name: 'W1',
          startTime: now.subtract(const Duration(days: 1)),
        ),
      ];
      final advice = RestDayAdvisor.getAdvice(workouts);
      expect(advice.toLowerCase(), contains('ready'));
    });

    test('prompts gym return when rested >=3 days', () {
      final now = DateTime.now();
      final workouts = [
        Workout(
          id: 'w1',
          name: 'W1',
          startTime: now.subtract(const Duration(days: 4)),
        ),
      ];
      final advice = RestDayAdvisor.getAdvice(workouts);
      expect(advice.toLowerCase(), contains('streak'));
    });
  });

  group('RestDayAdvisor - shouldRestToday', () {
    test('returns false when no workouts exist', () {
      expect(RestDayAdvisor.shouldRestToday([]), isFalse);
    });

    test('returns true when workout already done today', () {
      final now = DateTime.now();
      final w = Workout(id: 'w1', name: 'W1', startTime: now);
      expect(RestDayAdvisor.shouldRestToday([w]), isTrue);
    });

    test('returns false when rested 2 days ago and only 1 workout in week', () {
      final now = DateTime.now();
      final w = Workout(
        id: 'w1',
        name: 'W1',
        startTime: now.subtract(const Duration(days: 2)),
      );
      expect(RestDayAdvisor.shouldRestToday([w]), isFalse);
    });
  });
}


  group('RestDayAdvisor - extended workload scenarios', () {
    test('advises rest when 5 workouts in past 7 days', () {
      final now = DateTime.now();
      final workouts = List.generate(5, (i) => Workout(id: 'w$i', name: 'W$i', startTime: now.subtract(Duration(days: i))));
      expect(RestDayAdvisor.shouldRestToday(workouts), isTrue);
    });
  });
