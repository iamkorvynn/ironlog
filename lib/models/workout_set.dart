class WorkoutSet {
  final String id;
  final String workoutExerciseId;
  final int setOrder;
  final double weightKg;
  final int reps;
  final bool isCompleted;
  final double? rpe;
  final String? notes;

  const WorkoutSet({
    required this.id,
    required this.workoutExerciseId,
    required this.setOrder,
    required this.weightKg,
    required this.reps,
    this.isCompleted = false,
    this.rpe,
    this.notes,
  });

  /// Epley estimated 1RM formula: weight * (1 + reps / 30.0)
  double get estimated1Rm {
    if (reps <= 0 || weightKg <= 0) return 0.0;
    if (reps == 1) return weightKg;
    return weightKg * (1.0 + (reps / 30.0));
  }
}
