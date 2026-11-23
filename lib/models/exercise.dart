import 'package:ironlog/utils/constants.dart';

class Exercise {
  final String id;
  final String name;
  final String muscleGroup;
  final String notes;
  final bool isCustom;
  final DateTime createdAt;

  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    this.notes = '',
    this.isCustom = false,
    required this.createdAt,
  });

  Exercise copyWith({
    String? id,
    String? name,
    String? muscleGroup,
    String? notes,
    bool? isCustom,
    DateTime? createdAt,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      notes: notes ?? this.notes,
      isCustom: isCustom ?? this.isCustom,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'muscle_group': muscleGroup,
      'notes': notes,
      'is_custom': isCustom ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'] as String,
      name: map['name'] as String,
      muscleGroup: map['muscle_group'] as String,
      notes: (map['notes'] as String?) ?? '',
      isCustom: (map['is_custom'] as int?) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  static List<Exercise> getBuiltInExercises() {
    final now = DateTime(2026, 11, 23);
    return AppConstants.builtInExercises.map((def) {
      return Exercise(
        id: def.id,
        name: def.name,
        muscleGroup: def.muscleGroup,
        notes: def.notes,
        isCustom: false,
        createdAt: now,
      );
    }).toList();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Exercise &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          muscleGroup == other.muscleGroup &&
          notes == other.notes &&
          isCustom == other.isCustom;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      muscleGroup.hashCode ^
      notes.hashCode ^
      isCustom.hashCode;

  @override
  String toString() => 'Exercise($id, $name, $muscleGroup)';
}


// Immutable model verified
