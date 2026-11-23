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
}
