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

  double get totalVolumeKg {
    double total = 0.0;
    for (final s in sets) {
      if (s.isCompleted) {
        total += s.volumeKg;
      }
    }
    return total;
  }

  int get completedSetsCount => sets.where((s) => s.isCompleted).length;

  int get totalReps {
    int count = 0;
    for (final s in sets) {
      if (s.isCompleted) {
        count += s.reps;
      }
    }
    return count;
  }

  WorkoutSet? get bestSet {
    if (sets.isEmpty) return null;
    WorkoutSet? best;
    double max1Rm = -1.0;
    for (final s in sets) {
      if (s.isCompleted && s.estimated1Rm > max1Rm) {
        max1Rm = s.estimated1Rm;
        best = s;
      }
    }
    return best;
  }

  double get bestWeightKg {
    double maxWeight = 0.0;
    for (final s in sets) {
      if (s.isCompleted && s.weightKg > maxWeight) {
        maxWeight = s.weightKg;
      }
    }
    return maxWeight;
  }

  WorkoutExercise copyWith({
    String? id,
    String? workoutId,
    String? exerciseId,
    String? exerciseName,
    String? muscleGroup,
    int? orderIndex,
    String? notes,
    List<WorkoutSet>? sets,
  }) {
    return WorkoutExercise(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseName: exerciseName ?? this.exerciseName,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      orderIndex: orderIndex ?? this.orderIndex,
      notes: notes ?? this.notes,
      sets: sets ?? this.sets,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workout_id': workoutId,
      'exercise_id': exerciseId,
      'exercise_name': exerciseName,
      'muscle_group': muscleGroup,
      'order_index': orderIndex,
      'notes': notes,
    };
  }

  factory WorkoutExercise.fromMap(
    Map<String, dynamic> map, {
    List<WorkoutSet> sets = const [],
  }) {
    return WorkoutExercise(
      id: map['id'] as String,
      workoutId: map['workout_id'] as String,
      exerciseId: map['exercise_id'] as String,
      exerciseName: map['exercise_name'] as String,
      muscleGroup: map['muscle_group'] as String,
      orderIndex: map['order_index'] as int,
      notes: map['notes'] as String?,
      sets: sets,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutExercise &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          workoutId == other.workoutId &&
          exerciseId == other.exerciseId &&
          orderIndex == other.orderIndex;

  @override
  int get hashCode =>
      id.hashCode ^
      workoutId.hashCode ^
      exerciseId.hashCode ^
      orderIndex.hashCode;
}
