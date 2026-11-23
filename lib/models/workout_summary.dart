import 'package:ironlog/models/workout.dart';

class WorkoutSummary {
  final Workout? lastWorkout;
  final double thisWeekVolumeKg;
  final int thisWeekWorkouts;
  final String restDayAdvice;
  final int activeStreakWeeks;
  final int totalPrsCount;

  const WorkoutSummary({
    this.lastWorkout,
    required this.thisWeekVolumeKg,
    required this.thisWeekWorkouts,
    required this.restDayAdvice,
    required this.activeStreakWeeks,
    required this.totalPrsCount,
  });
}
