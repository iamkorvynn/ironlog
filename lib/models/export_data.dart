import 'package:ironlog/models/exercise.dart';
import 'package:ironlog/models/workout.dart';
import 'package:ironlog/models/personal_record.dart';
import 'package:ironlog/models/user_settings.dart';

class ExportData {
  final int version;
  final DateTime exportedAt;
  final List<Exercise> exercises;
  final List<Workout> workouts;
  final List<PersonalRecord> personalRecords;
  final UserSettings settings;

  const ExportData({
    this.version = 1,
    required this.exportedAt,
    required this.exercises,
    required this.workouts,
    required this.personalRecords,
    required this.settings,
  });

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'exported_at': exportedAt.toIso8601String(),
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'workouts': workouts.map((w) {
        final wMap = w.toMap();
        wMap['exercises'] = w.exercises.map((we) {
          final weMap = we.toMap();
          weMap['sets'] = we.sets.map((s) => s.toMap()).toList();
          return weMap;
        }).toList();
        return wMap;
      }).toList(),
      'personal_records': personalRecords.map((pr) => pr.toMap()).toList(),
      'settings': settings.toMap(),
    };
  }

  factory ExportData.fromJson(Map<String, dynamic> json) {
    final rawExercises = (json['exercises'] as List?) ?? [];
    final exercises = rawExercises
        .map((e) => Exercise.fromMap(e as Map<String, dynamic>))
        .toList();

    final rawWorkouts = (json['workouts'] as List?) ?? [];
    final workouts = rawWorkouts.map((w) {
      final wMap = w as Map<String, dynamic>;
      final rawWe = (wMap['exercises'] as List?) ?? [];
      final weList = rawWe.map((we) {
        final weMap = we as Map<String, dynamic>;
        final rawSets = (weMap['sets'] as List?) ?? [];
        final sets = rawSets
            .map((s) => WorkoutSet.fromMap(s as Map<String, dynamic>))
            .toList();
        return WorkoutExercise.fromMap(weMap, sets: sets);
      }).toList();
      return Workout.fromMap(wMap, exercises: weList);
    }).toList();

    final rawPrs = (json['personal_records'] as List?) ?? [];
    final prs = rawPrs
        .map((pr) => PersonalRecord.fromMap(pr as Map<String, dynamic>))
        .toList();

    final settingsMap = json['settings'] as Map<String, dynamic>?;
    final settings = settingsMap != null
        ? UserSettings.fromMap(settingsMap)
        : const UserSettings();

    return ExportData(
      version: (json['version'] as int?) ?? 1,
      exportedAt: json['exported_at'] != null
          ? DateTime.parse(json['exported_at'] as String)
          : DateTime.now(),
      exercises: exercises,
      workouts: workouts,
      personalRecords: prs,
      settings: settings,
    );
  }
}
