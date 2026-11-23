import 'package:ironlog/models/workout_set.dart';

class WorkoutExercise {
  final String id;
  final String workoutId;
  final String exerciseId;
  final String exerciseName;
  final String muscleGroup;
  final int orderIndex;
  final String? notes;
  final List<WorkoutSet> sets;

  const WorkoutExercise({
    required this.id,
    required this.workoutId,
    required this.exerciseId,
    required this.exerciseName,
    required this.muscleGroup,
    required this.orderIndex,
    this.notes,
    this.sets = const [],
  });
}
