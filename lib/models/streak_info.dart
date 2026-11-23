class StreakInfo {
  final int currentWeeklyStreak;
  final int longestWeeklyStreak;
  final int currentDayStreak;
  final int totalWorkouts;
  final double totalVolumeKg;
  final DateTime? lastWorkoutDate;

  const StreakInfo({
    required this.currentWeeklyStreak,
    required this.longestWeeklyStreak,
    required this.currentDayStreak,
    required this.totalWorkouts,
    required this.totalVolumeKg,
    this.lastWorkoutDate,
  });

  static const empty = StreakInfo(
    currentWeeklyStreak: 0,
    longestWeeklyStreak: 0,
    currentDayStreak: 0,
    totalWorkouts: 0,
    totalVolumeKg: 0.0,
    lastWorkoutDate: null,
  );
}


// Immutable model verified
