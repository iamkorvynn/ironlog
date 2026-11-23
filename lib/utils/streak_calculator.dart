import 'package:ironlog/models/workout.dart';
import 'package:ironlog/models/streak_info.dart';

class StreakCalculator {
  /// Calculates consecutive weekly streaks, total workouts, and total volume.
  static StreakInfo calculate(List<Workout> workouts) {
    if (workouts.isEmpty) {
      return StreakInfo.empty;
    }

    final sorted = List<Workout>.from(workouts)
      ..sort((a, b) => b.startTime.compareTo(a.startTime));

    final totalWorkouts = sorted.length;
    double totalVolume = 0.0;
    for (final w in sorted) {
      totalVolume += w.totalVolumeKg;
    }

    final lastWorkoutDate = sorted.first.startTime;

    // Group workouts into calendar weeks (year * 100 + weekNumber)
    final Set<String> activeWeeks = {};
    for (final w in sorted) {
      final monday = _getMondayOfWeek(w.startTime);
      final key = '${monday.year}-${monday.month}-${monday.day}';
      activeWeeks.add(key);
    }

    final now = DateTime.now();
    DateTime checkMonday = _getMondayOfWeek(now);

    int currentStreak = 0;
    final thisWeekKey =
        '${checkMonday.year}-${checkMonday.month}-${checkMonday.day}';

    // If no workout this week yet, check if there was one last week
    if (!activeWeeks.contains(thisWeekKey)) {
      checkMonday = checkMonday.subtract(const Duration(days: 7));
    }

    while (true) {
      final key =
          '${checkMonday.year}-${checkMonday.month}-${checkMonday.day}';
      if (activeWeeks.contains(key)) {
        currentStreak++;
        checkMonday = checkMonday.subtract(const Duration(days: 7));
      } else {
        break;
      }
    }

    return StreakInfo(
      currentWeeklyStreak: currentStreak,
      longestWeeklyStreak: currentStreak, // approximate
      currentDayStreak: _calculateDayStreak(sorted),
      totalWorkouts: totalWorkouts,
      totalVolumeKg: totalVolume,
      lastWorkoutDate: lastWorkoutDate,
    );
  }

  static DateTime _getMondayOfWeek(DateTime date) {
    final clean = DateTime(date.year, date.month, date.day);
    return clean.subtract(Duration(days: clean.weekday - 1));
  }

  static int _calculateDayStreak(List<Workout> sorted) {
    if (sorted.isEmpty) return 0;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final Set<String> activeDays = {};
    for (final w in sorted) {
      final d = DateTime(w.startTime.year, w.startTime.month, w.startTime.day);
      activeDays.add('${d.year}-${d.month}-${d.day}');
    }

    DateTime checkDate = today;
    final todayKey = '${today.year}-${today.month}-${today.day}';
    if (!activeDays.contains(todayKey)) {
      checkDate = today.subtract(const Duration(days: 1));
    }

    int streak = 0;
    while (true) {
      final key = '${checkDate.year}-${checkDate.month}-${checkDate.day}';
      if (activeDays.contains(key)) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return streak;
  }
}


// Set lookup optimization
