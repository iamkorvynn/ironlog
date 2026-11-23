import 'package:ironlog/models/personal_record.dart';
import 'package:ironlog/models/workout_set.dart';
import 'package:ironlog/models/workout_exercise.dart';
import 'package:ironlog/services/database_service.dart';

class PRService {
  final DatabaseService _dbService;

  PRService({DatabaseService? dbService})
      : _dbService = dbService ?? DatabaseService();

  /// Evaluates sets for a workout exercise against existing PRs.
  /// Returns a list of newly broken PRs.
  Future<List<PersonalRecord>> checkAndRecordPrs({
    required WorkoutExercise exercise,
    required String workoutId,
    required DateTime timestamp,
  }) async {
    final existingPrs =
        await _dbService.getPersonalRecordsByExercise(exercise.exerciseId);

    double currentBest1Rm = 0.0;
    double currentMaxWeight = 0.0;

    for (final pr in existingPrs) {
      if (pr.recordType == 'oneRepMax' && pr.value > currentBest1Rm) {
        currentBest1Rm = pr.value;
      }
      if (pr.recordType == 'maxWeight' && pr.value > currentMaxWeight) {
        currentMaxWeight = pr.value;
      }
    }

    final List<PersonalRecord> newPrs = [];

    for (final set in exercise.sets) {
      if (!set.isCompleted || set.weightKg <= 0 || set.reps <= 0) continue;

      // 1. Check 1RM PR
      final est1Rm = set.estimated1Rm;
      if (est1Rm > currentBest1Rm) {
        final pr = PersonalRecord(
          id: 'pr_1rm_${exercise.exerciseId}_${timestamp.millisecondsSinceEpoch}',
          exerciseId: exercise.exerciseId,
          exerciseName: exercise.exerciseName,
          workoutId: workoutId,
          recordType: 'oneRepMax',
          value: est1Rm,
          weightKg: set.weightKg,
          reps: set.reps,
          achievedAt: timestamp,
        );
        newPrs.add(pr);
        currentBest1Rm = est1Rm;
        await _dbService.savePersonalRecord(pr);
      }

      // 2. Check Max Weight PR
      if (set.weightKg > currentMaxWeight) {
        final pr = PersonalRecord(
          id: 'pr_wt_${exercise.exerciseId}_${timestamp.millisecondsSinceEpoch}',
          exerciseId: exercise.exerciseId,
          exerciseName: exercise.exerciseName,
          workoutId: workoutId,
          recordType: 'maxWeight',
          value: set.weightKg,
          weightKg: set.weightKg,
          reps: set.reps,
          achievedAt: timestamp,
        );
        newPrs.add(pr);
        currentMaxWeight = set.weightKg;
        await _dbService.savePersonalRecord(pr);
      }
    }

    return newPrs;
  }
}
