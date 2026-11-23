class WeeklyStats {
  final DateTime weekStart;
  final DateTime weekEnd;
  final double totalVolumeKg;
  final int workoutCount;
  final int totalSets;
  final int totalReps;

  const WeeklyStats({
    required this.weekStart,
    required this.weekEnd,
    required this.totalVolumeKg,
    required this.workoutCount,
    required this.totalSets,
    required this.totalReps,
  });

  WeeklyStats copyWith({
    DateTime? weekStart,
    DateTime? weekEnd,
    double? totalVolumeKg,
    int? workoutCount,
    int? totalSets,
    int? totalReps,
  }) {
    return WeeklyStats(
      weekStart: weekStart ?? this.weekStart,
      weekEnd: weekEnd ?? this.weekEnd,
      totalVolumeKg: totalVolumeKg ?? this.totalVolumeKg,
      workoutCount: workoutCount ?? this.workoutCount,
      totalSets: totalSets ?? this.totalSets,
      totalReps: totalReps ?? this.totalReps,
    );
  }
}
