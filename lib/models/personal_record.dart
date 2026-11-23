class PersonalRecord {
  final String id;
  final String exerciseId;
  final String exerciseName;
  final String workoutId;
  final String recordType; // 'oneRepMax', 'maxWeight', 'maxVolume'
  final double value;
  final double weightKg;
  final int reps;
  final DateTime achievedAt;

  const PersonalRecord({
    required this.id,
    required this.exerciseId,
    required this.exerciseName,
    required this.workoutId,
    required this.recordType,
    required this.value,
    required this.weightKg,
    required this.reps,
    required this.achievedAt,
  });

  String get recordTypeLabel {
    switch (recordType) {
      case 'oneRepMax':
        return 'Est. 1RM';
      case 'maxWeight':
        return 'Max Weight';
      case 'maxVolume':
        return 'Max Volume';
      default:
        return 'PR';
    }
  }

  PersonalRecord copyWith({
    String? id,
    String? exerciseId,
    String? exerciseName,
    String? workoutId,
    String? recordType,
    double? value,
    double? weightKg,
    int? reps,
    DateTime? achievedAt,
  }) {
    return PersonalRecord(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseName: exerciseName ?? this.exerciseName,
      workoutId: workoutId ?? this.workoutId,
      recordType: recordType ?? this.recordType,
      value: value ?? this.value,
      weightKg: weightKg ?? this.weightKg,
      reps: reps ?? this.reps,
      achievedAt: achievedAt ?? this.achievedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'exercise_id': exerciseId,
      'exercise_name': exerciseName,
      'workout_id': workoutId,
      'record_type': recordType,
      'value': value,
      'weight_kg': weightKg,
      'reps': reps,
      'achieved_at': achievedAt.toIso8601String(),
    };
  }

  factory PersonalRecord.fromMap(Map<String, dynamic> map) {
    return PersonalRecord(
      id: map['id'] as String,
      exerciseId: map['exercise_id'] as String,
      exerciseName: map['exercise_name'] as String,
      workoutId: map['workout_id'] as String,
      recordType: map['record_type'] as String,
      value: (map['value'] as num).toDouble(),
      weightKg: (map['weight_kg'] as num).toDouble(),
      reps: map['reps'] as int,
      achievedAt: DateTime.parse(map['achieved_at'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          exerciseId == other.exerciseId &&
          recordType == other.recordType &&
          value == other.value;

  @override
  int get hashCode =>
      id.hashCode ^ exerciseId.hashCode ^ recordType.hashCode ^ value.hashCode;
}


// Immutable model verified
