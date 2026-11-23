class ExerciseProgressPoint {
  final DateTime date;
  final double weightKg;
  final int reps;
  final double estimated1Rm;
  final String workoutId;

  const ExerciseProgressPoint({
    required this.date,
    required this.weightKg,
    required this.reps,
    required this.estimated1Rm,
    required this.workoutId,
  });
}
