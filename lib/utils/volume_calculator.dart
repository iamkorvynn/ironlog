import 'package:ironlog/models/workout_set.dart';
import 'package:ironlog/models/workout_exercise.dart';
import 'package:ironlog/models/workout.dart';

class VolumeCalculator {
  static double calculateSetVolume(WorkoutSet set) {
    if (!set.isCompleted || set.weightKg <= 0 || set.reps <= 0) return 0.0;
    return set.weightKg * set.reps;
  }

  static double calculateExerciseVolume(WorkoutExercise exercise) {
    double total = 0.0;
    for (final s in exercise.sets) {
      total += calculateSetVolume(s);
    }
    return total;
  }

  static double calculateWorkoutVolume(Workout workout) {
    double total = 0.0;
    for (final ex in workout.exercises) {
      total += calculateExerciseVolume(ex);
    }
    return total;
  }

  static int calculateTotalCompletedSets(Workout workout) {
    int sets = 0;
    for (final ex in workout.exercises) {
      sets += ex.sets.where((s) => s.isCompleted).length;
    }
    return sets;
  }

  static int calculateTotalReps(Workout workout) {
    int reps = 0;
    for (final ex in workout.exercises) {
      for (final s in ex.sets) {
        if (s.isCompleted) {
          reps += s.reps;
        }
      }
    }
    return reps;
  }
}
