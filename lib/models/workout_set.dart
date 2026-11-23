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

  /// Brzycki estimated 1RM formula: weight * (36 / (37 - reps))
  double get brzycki1Rm {
    if (reps <= 0 || weightKg <= 0) return 0.0;
    if (reps == 1) return weightKg;
    final clampedReps = reps > 36 ? 36 : reps;
    return weightKg * (36.0 / (37.0 - clampedReps));
  }

  /// Total volume lifted in this set (weight * reps)
  double get volumeKg {
    if (reps <= 0 || weightKg <= 0) return 0.0;
    return weightKg * reps;
  }

  WorkoutSet copyWith({
    String? id,
    String? workoutExerciseId,
    int? setOrder,
    double? weightKg,
    int? reps,
    bool? isCompleted,
    double? rpe,
    String? notes,
  }) {
    return WorkoutSet(
      id: id ?? this.id,
      workoutExerciseId: workoutExerciseId ?? this.workoutExerciseId,
      setOrder: setOrder ?? this.setOrder,
      weightKg: weightKg ?? this.weightKg,
      reps: reps ?? this.reps,
      isCompleted: isCompleted ?? this.isCompleted,
      rpe: rpe ?? this.rpe,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workout_exercise_id': workoutExerciseId,
      'set_order': setOrder,
      'weight_kg': weightKg,
      'reps': reps,
      'is_completed': isCompleted ? 1 : 0,
      'rpe': rpe,
      'notes': notes,
    };
  }

  factory WorkoutSet.fromMap(Map<String, dynamic> map) {
    return WorkoutSet(
      id: map['id'] as String,
      workoutExerciseId: map['workout_exercise_id'] as String,
      setOrder: map['set_order'] as int,
      weightKg: (map['weight_kg'] as num).toDouble(),
      reps: map['reps'] as int,
      isCompleted: (map['is_completed'] as int?) == 1,
      rpe: (map['rpe'] as num?)?.toDouble(),
      notes: map['notes'] as String?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutSet &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          workoutExerciseId == other.workoutExerciseId &&
          setOrder == other.setOrder &&
          weightKg == other.weightKg &&
          reps == other.reps &&
          isCompleted == other.isCompleted &&
          rpe == other.rpe;

  @override
  int get hashCode =>
      id.hashCode ^
      workoutExerciseId.hashCode ^
      setOrder.hashCode ^
      weightKg.hashCode ^
      reps.hashCode ^
      isCompleted.hashCode ^
      rpe.hashCode;

  @override
  String toString() =>
      'WorkoutSet(order: $setOrder, weight: ${weightKg}kg, reps: $reps, done: $isCompleted)';
}


// Immutable model verified
