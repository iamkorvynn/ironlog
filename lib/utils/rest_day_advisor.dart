import 'package:ironlog/models/workout.dart';

class RestDayAdvisor {
  /// Computes a smart suggestion based on recent workout history.
  static String getAdvice(List<Workout> recentWorkouts) {
    if (recentWorkouts.isEmpty) {
      return 'Welcome to IronLog! Start your first workout to begin tracking your progress.';
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Sort by startTime desc
    final sorted = List<Workout>.from(recentWorkouts)
      ..sort((a, b) => b.startTime.compareTo(a.startTime));

    final last = sorted.first;
    final lastDate = DateTime(
      last.startTime.year,
      last.startTime.month,
      last.startTime.day,
    );

    final daysSinceLast = today.difference(lastDate).inDays;

    // Count workouts in the last 7 days
    final sevenDaysAgo = today.subtract(const Duration(days: 7));
    final pastWeekWorkouts = sorted
        .where((w) => w.startTime.isAfter(sevenDaysAgo))
        .length;

    if (daysSinceLast == 0) {
      if (pastWeekWorkouts >= 4) {
        return 'Solid work today! You have trained $pastWeekWorkouts times this week — consider a full rest day tomorrow.';
      }
      return 'Great workout today! Hydrate, eat enough protein, and rest up for your next session.';
    }

    if (daysSinceLast == 1) {
      if (pastWeekWorkouts >= 4) {
        return 'Rest day advised today. Your muscles are recovering from high frequency this week.';
      }
      return 'You are rested and primed. Ready for a workout session today!';
    }

    if (daysSinceLast == 2) {
      return 'Well rested! Perfect day to hit the gym and push for new PRs.';
    }

    return 'It has been $daysSinceLast days since your last session. Time to get back in the gym and rebuild your streak!';
  }

  /// Returns true if today is recommended as a rest day.
  static bool shouldRestToday(List<Workout> recentWorkouts) {
    if (recentWorkouts.isEmpty) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final sorted = List<Workout>.from(recentWorkouts)
      ..sort((a, b) => b.startTime.compareTo(a.startTime));
    final last = sorted.first;
    final lastDate = DateTime(
      last.startTime.year,
      last.startTime.month,
      last.startTime.day,
    );

    final sevenDaysAgo = today.subtract(const Duration(days: 7));
    final pastWeekWorkouts = sorted
        .where((w) => w.startTime.isAfter(sevenDaysAgo))
        .length;

    return lastDate == today || pastWeekWorkouts >= 5;
  }
}


// Date comparison optimization


// Heuristics consider 7-day trailing training frequency
