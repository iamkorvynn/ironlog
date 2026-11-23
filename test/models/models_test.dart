import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/models/exercise.dart';
import 'package:ironlog/models/workout_set.dart';
import 'package:ironlog/models/workout_exercise.dart';
import 'package:ironlog/models/workout.dart';
import 'package:ironlog/models/personal_record.dart';
import 'package:ironlog/models/user_settings.dart';
import 'package:ironlog/models/rest_timer_state.dart';
import 'package:ironlog/models/export_data.dart';

void main() {
  group('Exercise model', () {
    test('getBuiltInExercises contains 12 required basic exercises', () {
      final builtIns = Exercise.getBuiltInExercises();
      expect(builtIns.length, 12);
      final names = builtIns.map((e) => e.name).toList();
      expect(names, contains('Bench Press'));
      expect(names, contains('Squat'));
      expect(names, contains('Deadlift'));
      expect(names, contains('Overhead Press'));
      expect(names, contains('Barbell Row'));
      expect(names, contains('Pull-Up'));
      expect(names, contains('Dips'));
      expect(names, contains('Bicep Curl'));
      expect(names, contains('Tricep Extension'));
      expect(names, contains('Leg Press'));
      expect(names, contains('Lat Pulldown'));
      expect(names, contains('Plank'));
    });

    test('toMap and fromMap roundtrip', () {
      final now = DateTime(2026, 11, 23);
      final ex = Exercise(
        id: 'c1',
        name: 'Lateral Raise',
        muscleGroup: 'Shoulders',
        notes: 'Side delts focus',
        isCustom: true,
        createdAt: now,
      );
      final map = ex.toMap();
      final revived = Exercise.fromMap(map);
      expect(revived.id, ex.id);
      expect(revived.name, ex.name);
      expect(revived.muscleGroup, ex.muscleGroup);
      expect(revived.isCustom, true);
    });

    test('copyWith updates specified fields', () {
      final ex = Exercise(
        id: 'e1',
        name: 'Curl',
        muscleGroup: 'Arms',
        createdAt: DateTime(2026, 11, 23),
      );
      final updated = ex.copyWith(name: 'Hammer Curl');
      expect(updated.name, 'Hammer Curl');
      expect(updated.id, ex.id);
    });
  });

  group('WorkoutSet model', () {
    test('calculates Epley 1RM accurately', () {
      const set = WorkoutSet(
        id: 's1',
        workoutExerciseId: 'we1',
        setOrder: 1,
        weightKg: 100,
        reps: 10,
      );
      expect(set.estimated1Rm, closeTo(133.33, 0.01));
    });

    test('calculates volumeKg', () {
      const set = WorkoutSet(
        id: 's1',
        workoutExerciseId: 'we1',
        setOrder: 1,
        weightKg: 85,
        reps: 8,
      );
      expect(set.volumeKg, 680.0);
    });

    test('toMap and fromMap roundtrip', () {
      const set = WorkoutSet(
        id: 's1',
        workoutExerciseId: 'we1',
        setOrder: 2,
        weightKg: 100,
        reps: 6,
        isCompleted: true,
        rpe: 8.5,
        notes: 'Felt solid',
      );
      final map = set.toMap();
      final revived = WorkoutSet.fromMap(map);
      expect(revived.id, set.id);
      expect(revived.weightKg, 100.0);
      expect(revived.reps, 6);
      expect(revived.isCompleted, true);
      expect(revived.rpe, 8.5);
    });
  });

  group('WorkoutExercise model', () {
    test('bestSet returns set with highest estimated 1RM among completed sets', () {
      const ex = WorkoutExercise(
        id: 'we1',
        workoutId: 'w1',
        exerciseId: 'e1',
        exerciseName: 'Bench',
        muscleGroup: 'Chest',
        orderIndex: 0,
        sets: [
          WorkoutSet(
            id: 's1',
            workoutExerciseId: 'we1',
            setOrder: 1,
            weightKg: 60,
            reps: 10,
            isCompleted: true, // 1RM = 80
          ),
          WorkoutSet(
            id: 's2',
            workoutExerciseId: 'we1',
            setOrder: 2,
            weightKg: 80,
            reps: 5,
            isCompleted: true, // 1RM = 93.33
          ),
          WorkoutSet(
            id: 's3',
            workoutExerciseId: 'we1',
            setOrder: 3,
            weightKg: 120,
            reps: 10,
            isCompleted: false, // not completed, must ignore
          ),
        ],
      );
      expect(ex.bestSet?.id, 's2');
      expect(ex.bestWeightKg, 80.0);
      expect(ex.completedSetsCount, 2);
    });
  });

  group('Workout model', () {
    test('isCompleted reflects endTime', () {
      final wActive = Workout(
        id: 'w1',
        name: 'Active',
        startTime: DateTime.now(),
      );
      expect(wActive.isCompleted, isFalse);

      final wDone = wActive.copyWith(endTime: DateTime.now());
      expect(wDone.isCompleted, isTrue);
    });
  });

  group('PersonalRecord model', () {
    test('recordTypeLabel provides clear names', () {
      final pr1 = PersonalRecord(
        id: 'p1',
        exerciseId: 'e1',
        exerciseName: 'Squat',
        workoutId: 'w1',
        recordType: 'oneRepMax',
        value: 150,
        weightKg: 130,
        reps: 5,
        achievedAt: DateTime.now(),
      );
      expect(pr1.recordTypeLabel, 'Est. 1RM');

      final pr2 = pr1.copyWith(recordType: 'maxWeight');
      expect(pr2.recordTypeLabel, 'Max Weight');
    });
  });

  group('UserSettings model', () {
    test('isKg and isLbs getters work correctly', () {
      const sKg = UserSettings(weightUnit: 'kg');
      expect(sKg.isKg, isTrue);
      expect(sKg.isLbs, isFalse);

      const sLbs = UserSettings(weightUnit: 'lbs');
      expect(sLbs.isKg, isFalse);
      expect(sLbs.isLbs, isTrue);
    });
  });

  group('RestTimerState model', () {
    test('progress calculates percentage', () {
      const state = RestTimerState(totalSeconds: 60, remainingSeconds: 30);
      expect(state.progress, 0.5);
    });

    test('formattedRemaining outputs MM:SS', () {
      const state = RestTimerState(totalSeconds: 90, remainingSeconds: 65);
      expect(state.formattedRemaining, '01:05');
    });
  });

  group('ExportData model', () {
    test('toJson and fromJson preserves data integrity', () {
      final now = DateTime(2026, 11, 23);
      final export = ExportData(
        version: 1,
        exportedAt: now,
        exercises: Exercise.getBuiltInExercises(),
        workouts: [],
        personalRecords: [],
        settings: const UserSettings(weightUnit: 'lbs'),
      );

      final json = export.toJson();
      final revived = ExportData.fromJson(json);

      expect(revived.exercises.length, 12);
      expect(revived.settings.weightUnit, 'lbs');
    });
  });
}


  group('Exercise model - equality details', () {
    test('identical exercises compare equal', () {
      final now = DateTime(2026, 11, 23);
      final e1 = Exercise(id: '1', name: 'Squat', muscleGroup: 'Legs', createdAt: now);
      final e2 = Exercise(id: '1', name: 'Squat', muscleGroup: 'Legs', createdAt: now);
      expect(e1, equals(e2));
      expect(e1.hashCode, equals(e2.hashCode));
    });
  });
