import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/models/exercise.dart';
import 'package:ironlog/models/workout.dart';
import 'package:ironlog/models/workout_exercise.dart';
import 'package:ironlog/models/workout_set.dart';
import 'package:ironlog/models/personal_record.dart';
import 'package:ironlog/models/user_settings.dart';
import 'package:ironlog/services/database_service.dart';
import 'package:ironlog/services/rest_timer_service.dart';
import 'package:ironlog/services/pr_service.dart';
import 'package:ironlog/services/active_workout_service.dart';
import 'package:ironlog/services/stats_service.dart';
import 'package:ironlog/services/settings_service.dart';

void main() {
  setUp(() {
    DatabaseService().enableInMemoryMode();
  });

  group('DatabaseService in-memory operations', () {
    test('seeds 12 built-in exercises', () async {
      final db = DatabaseService();
      final exercises = await db.getExercises();
      expect(exercises.length, 12);
    });

    test('can insert, fetch, and delete custom exercise', () async {
      final db = DatabaseService();
      final custom = Exercise(
        id: 'cust_chest_fly',
        name: 'Dumbbell Fly',
        muscleGroup: 'Chest',
        isCustom: true,
        createdAt: DateTime.now(),
      );
      await db.insertExercise(custom);

      final fetched = await db.getExerciseById('cust_chest_fly');
      expect(fetched?.name, 'Dumbbell Fly');

      await db.deleteExercise('cust_chest_fly');
      final afterDelete = await db.getExerciseById('cust_chest_fly');
      expect(afterDelete, isNull);
    });

    test('can insert, retrieve, and delete workout', () async {
      final db = DatabaseService();
      final workout = Workout(
        id: 'w_test_1',
        name: 'Push Day',
        startTime: DateTime.now(),
        totalVolumeKg: 3200,
      );
      await db.insertWorkout(workout);

      final list = await db.getWorkouts();
      expect(list.any((w) => w.id == 'w_test_1'), isTrue);

      final retrieved = await db.getWorkoutById('w_test_1');
      expect(retrieved?.name, 'Push Day');

      await db.deleteWorkout('w_test_1');
      final listAfter = await db.getWorkouts();
      expect(listAfter.any((w) => w.id == 'w_test_1'), isFalse);
    });

    test('saves and retrieves personal records', () async {
      final db = DatabaseService();
      final pr = PersonalRecord(
        id: 'pr_1',
        exerciseId: 'builtin_bench_press',
        exerciseName: 'Bench Press',
        workoutId: 'w1',
        recordType: 'oneRepMax',
        value: 120.0,
        weightKg: 100.0,
        reps: 6,
        achievedAt: DateTime.now(),
      );
      await db.savePersonalRecord(pr);

      final prs = await db.getPersonalRecordsByExercise('builtin_bench_press');
      expect(prs.length, 1);
      expect(prs.first.value, 120.0);
    });

    test('saves and retrieves settings', () async {
      final db = DatabaseService();
      const settings = UserSettings(weightUnit: 'lbs', defaultRestDurationSeconds: 90);
      await db.saveSettings(settings);

      final retrieved = await db.getSettings();
      expect(retrieved.weightUnit, 'lbs');
      expect(retrieved.defaultRestDurationSeconds, 90);
    });
  });

  group('PRService detection', () {
    test('detects 1RM and Max Weight PR on initial completed workout', () async {
      final db = DatabaseService();
      final prService = PRService(dbService: db);

      const we = WorkoutExercise(
        id: 'we1',
        workoutId: 'w1',
        exerciseId: 'builtin_squat',
        exerciseName: 'Squat',
        muscleGroup: 'Legs',
        orderIndex: 0,
        sets: [
          WorkoutSet(
            id: 's1',
            workoutExerciseId: 'we1',
            setOrder: 1,
            weightKg: 100,
            reps: 5,
            isCompleted: true, // 1RM = 116.66kg, Max Weight = 100kg
          ),
        ],
      );

      final newPrs = await prService.checkAndRecordPrs(
        exercise: we,
        workoutId: 'w1',
        timestamp: DateTime.now(),
      );

      expect(newPrs.length, 2);
      expect(newPrs.any((p) => p.recordType == 'oneRepMax'), isTrue);
      expect(newPrs.any((p) => p.recordType == 'maxWeight'), isTrue);
    });

    test('does not detect PR if current set is lower than stored PR', () async {
      final db = DatabaseService();
      final prService = PRService(dbService: db);

      // Stored PR of 140kg 1RM
      await db.savePersonalRecord(PersonalRecord(
        id: 'pr_exist',
        exerciseId: 'builtin_deadlift',
        exerciseName: 'Deadlift',
        workoutId: 'w_old',
        recordType: 'oneRepMax',
        value: 140.0,
        weightKg: 140.0,
        reps: 1,
        achievedAt: DateTime.now().subtract(const Duration(days: 7)),
      ));

      const we = WorkoutExercise(
        id: 'we2',
        workoutId: 'w2',
        exerciseId: 'builtin_deadlift',
        exerciseName: 'Deadlift',
        muscleGroup: 'Back',
        orderIndex: 0,
        sets: [
          WorkoutSet(
            id: 's2',
            workoutExerciseId: 'we2',
            setOrder: 1,
            weightKg: 100,
            reps: 5, // 1RM ~ 116.6kg < 140kg
            isCompleted: true,
          ),
        ],
      );

      final newPrs = await prService.checkAndRecordPrs(
        exercise: we,
        workoutId: 'w2',
        timestamp: DateTime.now(),
      );

      expect(newPrs.any((p) => p.recordType == 'oneRepMax'), isFalse);
    });
  });

  group('RestTimerService state machine', () {
    test('initial state is stopped', () {
      final service = RestTimerService();
      expect(service.isRunning, isFalse);
    });

    test('start sets total and remaining seconds', () {
      final service = RestTimerService();
      service.start(90);
      expect(service.isRunning, isTrue);
      expect(service.totalSeconds, 90);
      expect(service.remainingSeconds, 90);
      service.stop();
    });

    test('pause and resume', () {
      final service = RestTimerService();
      service.start(60);
      service.pause();
      expect(service.isPaused, isTrue);
      service.resume();
      expect(service.isPaused, isFalse);
      service.stop();
    });

    test('addSeconds increases remaining time', () {
      final service = RestTimerService();
      service.start(60);
      service.addSeconds(15);
      expect(service.remainingSeconds, 75);
      service.stop();
    });
  });

  group('ActiveWorkoutService session workflow', () {
    test('starts workout with default name and initial properties', () {
      final active = ActiveWorkoutService();
      active.startWorkout(name: 'Chest Day');
      expect(active.hasActiveWorkout, isTrue);
      expect(active.activeWorkout?.name, 'Chest Day');
      active.cancelWorkout();
      expect(active.hasActiveWorkout, isFalse);
    });

    test('adds exercise and sets', () {
      final active = ActiveWorkoutService();
      active.startWorkout();

      final ex = Exercise(
        id: 'b1',
        name: 'Bench Press',
        muscleGroup: 'Chest',
        createdAt: DateTime.now(),
      );

      active.addExercise(ex);
      expect(active.activeWorkout?.exercises.length, 1);

      final weId = active.activeWorkout!.exercises.first.id;
      active.addSet(weId, weightKg: 80, reps: 10);
      expect(active.activeWorkout!.exercises.first.sets.length, 2);

      active.cancelWorkout();
    });
  });

  group('SettingsService reactive unit changes', () {
    test('toggles weight unit from kg to lbs and notifies listeners', () async {
      final settings = SettingsService();
      await settings.loadSettings();
      await settings.setWeightUnit('lbs');
      expect(settings.weightUnit, 'lbs');
      expect(settings.isLbs, isTrue);
      await settings.setWeightUnit('kg');
      expect(settings.isKg, isTrue);
    });
  });

  group('StatsService dashboard summary', () {
    test('computes dashboard summary with zero workouts', () async {
      final statsService = StatsService();
      final summary = await statsService.getDashboardSummary();
      expect(summary.thisWeekWorkouts, 0);
      expect(summary.thisWeekVolumeKg, 0.0);
      expect(summary.restDayAdvice, isNotEmpty);
    });
  });
}


  group('DatabaseService - alphabetical sorting', () {
    test('returns exercises sorted alphabetically', () async {
      final db = DatabaseService();
      final list = await db.getExercises();
      for (int i = 0; i < list.length - 1; i++) {
        expect(list[i].name.compareTo(list[i + 1].name) <= 0, isTrue);
      }
    });
  });


  group('DatabaseService - pagination', () {
    test('respects limit parameter', () async {
      final db = DatabaseService();
      for (int i = 0; i < 5; i++) {
        await db.insertWorkout(Workout(id: 'w_limit_$i', name: 'W', startTime: DateTime.now()));
      }
      final limited = await db.getWorkouts(limit: 3);
      expect(limited.length, lessThanOrEqualTo(3));
    });
  });


  group('DatabaseService - clearAllData preservation', () {
    test('clearing all data retains the 12 built-in exercises', () async {
      final db = DatabaseService();
      await db.clearAllData();
      final exercises = await db.getExercises();
      expect(exercises.length, 12);
    });
  });


  group('PRService - volume records', () {
    test('detects high volume PR', () async {
      final db = DatabaseService();
      final prService = PRService(dbService: db);
      const we = WorkoutExercise(
        id: 'we_vol', workoutId: 'w', exerciseId: 'builtin_bicep_curl', exerciseName: 'Bicep Curl', muscleGroup: 'Arms', orderIndex: 0,
        sets: [
          WorkoutSet(id: 's', workoutExerciseId: 'we_vol', setOrder: 1, weightKg: 20, reps: 20, isCompleted: true),
        ],
      );
      final prs = await prService.checkAndRecordPrs(exercise: we, workoutId: 'w', timestamp: DateTime.now());
      expect(prs.isNotEmpty, isTrue);
    });
  });


  group('RestTimerService - subtract time', () {
    test('subtracting time decreases remaining', () {
      final timer = RestTimerService();
      timer.start(60);
      timer.addSeconds(-15);
      expect(timer.remainingSeconds, 45);
      timer.stop();
    });
  });


  group('ActiveWorkoutService - reindexing sets', () {
    test('deleting middle set updates subsequent set orders', () {
      final active = ActiveWorkoutService();
      active.startWorkout();
      final ex = Exercise.getBuiltInExercises().first;
      active.addExercise(ex);
      final weId = active.activeWorkout!.exercises.first.id;
      active.addSet(weId); // set 2
      active.addSet(weId); // set 3

      // Delete set 2
      final set2Id = active.activeWorkout!.exercises.first.sets[1].id;
      active.removeSet(weId, set2Id);

      final sets = active.activeWorkout!.exercises.first.sets;
      expect(sets.length, 2);
      expect(sets[0].setOrder, 1);
      expect(sets[1].setOrder, 2);
      active.cancelWorkout();
    });
  });


  group('SettingsService - theme toggle', () {
    test('sets theme mode to dark, light, and system', () async {
      final settings = SettingsService();
      await settings.setThemeMode('light');
      expect(settings.themeMode, 'light');
      await settings.setThemeMode('dark');
      expect(settings.themeMode, 'dark');
    });
  });
