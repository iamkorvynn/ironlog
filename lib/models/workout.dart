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

  double calculateTotalVolume() {
    double total = 0.0;
    for (final ex in exercises) {
      total += ex.totalVolumeKg;
    }
    return total;
  }

  int calculateTotalSets() {
    int sets = 0;
    for (final ex in exercises) {
      sets += ex.completedSetsCount;
    }
    return sets;
  }

  int calculateTotalReps() {
    int reps = 0;
    for (final ex in exercises) {
      reps += ex.totalReps;
    }
    return reps;
  }

  Workout copyWith({
    String? id,
    String? name,
    DateTime? startTime,
    DateTime? endTime,
    int? durationSeconds,
    String? notes,
    double? totalVolumeKg,
    int? totalSets,
    int? totalReps,
    List<WorkoutExercise>? exercises,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      notes: notes ?? this.notes,
      totalVolumeKg: totalVolumeKg ?? this.totalVolumeKg,
      totalSets: totalSets ?? this.totalSets,
      totalReps: totalReps ?? this.totalReps,
      exercises: exercises ?? this.exercises,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'duration_seconds': durationSeconds,
      'notes': notes,
      'total_volume_kg': totalVolumeKg,
      'total_sets': totalSets,
      'total_reps': totalReps,
    };
  }

  factory Workout.fromMap(
    Map<String, dynamic> map, {
    List<WorkoutExercise> exercises = const [],
  }) {
    return Workout(
      id: map['id'] as String,
      name: map['name'] as String,
      startTime: DateTime.parse(map['start_time'] as String),
      endTime: map['end_time'] != null
          ? DateTime.parse(map['end_time'] as String)
          : null,
      durationSeconds: (map['duration_seconds'] as int?) ?? 0,
      notes: map['notes'] as String?,
      totalVolumeKg: (map['total_volume_kg'] as num?)?.toDouble() ?? 0.0,
      totalSets: (map['total_sets'] as int?) ?? 0,
      totalReps: (map['total_reps'] as int?) ?? 0,
      exercises: exercises,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Workout &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          startTime == other.startTime &&
          endTime == other.endTime;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ startTime.hashCode ^ endTime.hashCode;
}


// Immutable model verified
