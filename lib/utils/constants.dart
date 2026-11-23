class BuiltInExerciseDef {
  final String id;
  final String name;
  final String muscleGroup;
  final String notes;

  const BuiltInExerciseDef({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.notes,
  });
}

class AppConstants {
  static const String appName = 'IronLog';
  static const String appVersion = '1.0.0';

  static const List<String> muscleGroups = [
    'All',
    'Chest',
    'Back',
    'Legs',
    'Shoulders',
    'Arms',
    'Core',
    'Other',
  ];

  static const List<int> defaultRestPresets = [30, 60, 90, 120];

  static const List<BuiltInExerciseDef> builtInExercises = [
    BuiltInExerciseDef(
      id: 'builtin_bench_press',
      name: 'Bench Press',
      muscleGroup: 'Chest',
      notes: 'Compound barbell movement for chest, shoulders, and triceps.',
    ),
    BuiltInExerciseDef(
      id: 'builtin_squat',
      name: 'Squat',
      muscleGroup: 'Legs',
      notes: 'Compound barbell squat for quadriceps, hamstrings, and glutes.',
    ),
    BuiltInExerciseDef(
      id: 'builtin_deadlift',
      name: 'Deadlift',
      muscleGroup: 'Back',
      notes: 'Posterior chain compound barbell lift for back, glutes, and legs.',
    ),
    BuiltInExerciseDef(
      id: 'builtin_overhead_press',
      name: 'Overhead Press',
      muscleGroup: 'Shoulders',
      notes: 'Standing barbell press overhead for shoulders and triceps.',
    ),
    BuiltInExerciseDef(
      id: 'builtin_barbell_row',
      name: 'Barbell Row',
      muscleGroup: 'Back',
      notes: 'Bent-over barbell row targeting the upper back and lats.',
    ),
    BuiltInExerciseDef(
      id: 'builtin_pull_up',
      name: 'Pull-Up',
      muscleGroup: 'Back',
      notes: 'Bodyweight vertical pulling movement for lats and biceps.',
    ),
    BuiltInExerciseDef(
      id: 'builtin_dips',
      name: 'Dips',
      muscleGroup: 'Chest',
      notes: 'Bodyweight pushing exercise on parallel bars for chest and triceps.',
    ),
    BuiltInExerciseDef(
      id: 'builtin_bicep_curl',
      name: 'Bicep Curl',
      muscleGroup: 'Arms',
      notes: 'Isolation movement targeting biceps using dumbbell or barbell.',
    ),
    BuiltInExerciseDef(
      id: 'builtin_tricep_extension',
      name: 'Tricep Extension',
      muscleGroup: 'Arms',
      notes: 'Cable or dumbbell overhead extension for triceps isolation.',
    ),
    BuiltInExerciseDef(
      id: 'builtin_leg_press',
      name: 'Leg Press',
      muscleGroup: 'Legs',
      notes: 'Machine compound press for quads and glutes.',
    ),
    BuiltInExerciseDef(
      id: 'builtin_lat_pulldown',
      name: 'Lat Pulldown',
      muscleGroup: 'Back',
      notes: 'Cable vertical pull for lats and upper back muscles.',
    ),
    BuiltInExerciseDef(
      id: 'builtin_plank',
      name: 'Plank',
      muscleGroup: 'Core',
      notes: 'Isometric core stability hold targeting abdominals.',
    ),
  ];
}
