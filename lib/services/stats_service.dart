import 'package:ironlog/models/workout_summary.dart';
import 'package:ironlog/models/streak_info.dart';
import 'package:ironlog/services/database_service.dart';
import 'package:ironlog/utils/rest_day_advisor.dart';
import 'package:ironlog/utils/streak_calculator.dart';
import 'package:ironlog/utils/date_utils.dart';

class StatsService {
  final DatabaseService _dbService;

  StatsService({DatabaseService? dbService})
      : _dbService = dbService ?? DatabaseService();

  Future<WorkoutSummary> getDashboardSummary() async {
    final workouts = await _dbService.getWorkouts(limit: 50);
    final prs = await _dbService.getAllPersonalRecords();

    final now = DateTime.now();
    final weekStart = AppDateUtils.startOfWeek(now);
    final weekEnd = AppDateUtils.endOfWeek(now);

    final thisWeekWorkouts = workouts.where((w) {
      return w.startTime.isAfter(weekStart) && w.startTime.isBefore(weekEnd);
    }).toList();

    double thisWeekVolume = 0.0;
    for (final w in thisWeekWorkouts) {
      thisWeekVolume += w.totalVolumeKg;
    }

    final restAdvice = RestDayAdvisor.getAdvice(workouts);
    final streak = StreakCalculator.calculate(workouts);

    return WorkoutSummary(
      lastWorkout: workouts.isNotEmpty ? workouts.first : null,
      thisWeekVolumeKg: thisWeekVolume,
      thisWeekWorkouts: thisWeekWorkouts.length,
      restDayAdvice: restAdvice,
      activeStreakWeeks: streak.currentWeeklyStreak,
      totalPrsCount: prs.length,
    );
  }

  Future<StreakInfo> getStreakInfo() async {
    final workouts = await _dbService.getWorkouts(limit: 200);
    return StreakCalculator.calculate(workouts);
  }
}
