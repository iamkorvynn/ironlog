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
}
