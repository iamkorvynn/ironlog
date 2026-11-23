import 'package:ironlog/models/workout_exercise.dart';

class Workout {
  final String id;
  final String name;
  final DateTime startTime;
  final DateTime? endTime;
  final int durationSeconds;
  final String? notes;
  final double totalVolumeKg;
  final int totalSets;
  final int totalReps;
  final List<WorkoutExercise> exercises;

  const Workout({
    required this.id,
    required this.name,
    required this.startTime,
    this.endTime,
    this.durationSeconds = 0,
    this.notes,
    this.totalVolumeKg = 0.0,
    this.totalSets = 0,
    this.totalReps = 0,
    this.exercises = const [],
  });

  bool get isCompleted => endTime != null;
}
