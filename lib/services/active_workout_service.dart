import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:ironlog/models/exercise.dart';
import 'package:ironlog/models/workout.dart';
import 'package:ironlog/models/workout_exercise.dart';
import 'package:ironlog/models/workout_set.dart';
import 'package:ironlog/models/personal_record.dart';
import 'package:ironlog/services/database_service.dart';
import 'package:ironlog/services/pr_service.dart';
import 'package:ironlog/services/rest_timer_service.dart';
import 'package:ironlog/services/settings_service.dart';
import 'package:ironlog/utils/sound_vibration_helper.dart';

class ActiveWorkoutService extends ChangeNotifier {
  static final ActiveWorkoutService _instance =
      ActiveWorkoutService._internal();
  factory ActiveWorkoutService() => _instance;
  ActiveWorkoutService._internal();

  final DatabaseService _db = DatabaseService();
  final PRService _prService = PRService();

  Workout? _activeWorkout;
  Timer? _elapsedTimer;
  int _elapsedSeconds = 0;

  Workout? get activeWorkout => _activeWorkout;
  bool get hasActiveWorkout => _activeWorkout != null;
  int get elapsedSeconds => _elapsedSeconds;

  void startWorkout({String? name}) {
    if (_activeWorkout != null) return;

    final now = DateTime.now();
    final defaultName =
        name ?? 'Workout ${now.day}/${now.month}';

    _activeWorkout = Workout(
      id: 'workout_${now.millisecondsSinceEpoch}',
      name: defaultName,
      startTime: now,
      durationSeconds: 0,
      exercises: [],
    );

    _elapsedSeconds = 0;
    _elapsedTimer?.cancel();
    _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedSeconds++;
      if (_activeWorkout != null) {
        _activeWorkout = _activeWorkout!.copyWith(
          durationSeconds: _elapsedSeconds,
        );
      }
      notifyListeners();
    });

    notifyListeners();
  }

  void updateWorkoutName(String name) {
    if (_activeWorkout == null) return;
    _activeWorkout = _activeWorkout!.copyWith(name: name);
    notifyListeners();
  }

  void updateWorkoutNotes(String notes) {
    if (_activeWorkout == null) return;
    _activeWorkout = _activeWorkout!.copyWith(notes: notes);
    notifyListeners();
  }

  void addExercise(Exercise exercise) {
    if (_activeWorkout == null) return;

    final weId =
        'we_${exercise.id}_${DateTime.now().millisecondsSinceEpoch}';

    // Auto-add first empty set
    final firstSet = WorkoutSet(
      id: 'set_${weId}_1',
      workoutExerciseId: weId,
      setOrder: 1,
      weightKg: 0.0,
      reps: 0,
      isCompleted: false,
    );

    final we = WorkoutExercise(
      id: weId,
      workoutId: _activeWorkout!.id,
      exerciseId: exercise.id,
      exerciseName: exercise.name,
      muscleGroup: exercise.muscleGroup,
      orderIndex: _activeWorkout!.exercises.length,
      sets: [firstSet],
    );

    final updatedExercises = List<WorkoutExercise>.from(_activeWorkout!.exercises)
      ..add(we);

    _activeWorkout = _activeWorkout!.copyWith(exercises: updatedExercises);
    notifyListeners();
  }

  void removeExercise(String weId) {
    if (_activeWorkout == null) return;
    final updated = _activeWorkout!.exercises.where((e) => e.id != weId).toList();
    _activeWorkout = _activeWorkout!.copyWith(exercises: updated);
    notifyListeners();
  }

  void addSet(String weId, {double? weightKg, int? reps}) {
    if (_activeWorkout == null) return;

    final updated = _activeWorkout!.exercises.map((we) {
      if (we.id != weId) return we;

      final nextOrder = we.sets.length + 1;
      final prevSet = we.sets.isNotEmpty ? we.sets.last : null;

      final newSet = WorkoutSet(
        id: 'set_${weId}_$nextOrder',
        workoutExerciseId: weId,
        setOrder: nextOrder,
        weightKg: weightKg ?? prevSet?.weightKg ?? 0.0,
        reps: reps ?? prevSet?.reps ?? 0,
        isCompleted: false,
      );

      final newSets = List<WorkoutSet>.from(we.sets)..add(newSet);
      return we.copyWith(sets: newSets);
    }).toList();

    _activeWorkout = _activeWorkout!.copyWith(exercises: updated);
    notifyListeners();
  }

  void removeSet(String weId, String setId) {
    if (_activeWorkout == null) return;

    final updated = _activeWorkout!.exercises.map((we) {
      if (we.id != weId) return we;
      final newSets = we.sets.where((s) => s.id != setId).toList();
      // Re-index set orders
      final reindexed = <WorkoutSet>[];
      for (int i = 0; i < newSets.length; i++) {
        reindexed.add(newSets[i].copyWith(setOrder: i + 1));
      }
      return we.copyWith(sets: reindexed);
    }).toList();

    _activeWorkout = _activeWorkout!.copyWith(exercises: updated);
    notifyListeners();
  }

  void updateSet(
    String weId,
    String setId, {
    double? weightKg,
    int? reps,
    double? rpe,
    bool? isCompleted,
    String? notes,
  }) {
    if (_activeWorkout == null) return;

    final updated = _activeWorkout!.exercises.map((we) {
      if (we.id != weId) return we;
      final newSets = we.sets.map((s) {
        if (s.id != setId) return s;
        return s.copyWith(
          weightKg: weightKg,
          reps: reps,
          rpe: rpe,
          isCompleted: isCompleted,
          notes: notes,
        );
      }).toList();
      return we.copyWith(sets: newSets);
    }).toList();

    _activeWorkout = _activeWorkout!.copyWith(exercises: updated);
    notifyListeners();
  }

  Future<void> toggleSetCompleted(String weId, String setId) async {
    if (_activeWorkout == null) return;

    bool willBeCompleted = false;

    final updated = _activeWorkout!.exercises.map((we) {
      if (we.id != weId) return we;
      final newSets = we.sets.map((s) {
        if (s.id != setId) return s;
        willBeCompleted = !s.isCompleted;
        return s.copyWith(isCompleted: willBeCompleted);
      }).toList();
      return we.copyWith(sets: newSets);
    }).toList();

    _activeWorkout = _activeWorkout!.copyWith(exercises: updated);
    notifyListeners();

    if (willBeCompleted) {
      await SoundVibrationHelper.triggerSetCompleteHaptic();
      final settings = SettingsService().settings;
      if (settings.autoStartRestTimer) {
        RestTimerService().start(settings.defaultRestDurationSeconds);
      }
    }
  }

  Future<List<PersonalRecord>> finishWorkout() async {
    if (_activeWorkout == null) return [];

    _elapsedTimer?.cancel();
    _elapsedTimer = null;

    final now = DateTime.now();
    final volume = _activeWorkout!.calculateTotalVolume();
    final sets = _activeWorkout!.calculateTotalSets();
    final reps = _activeWorkout!.calculateTotalReps();

    final completedWorkout = _activeWorkout!.copyWith(
      endTime: now,
      durationSeconds: _elapsedSeconds,
      totalVolumeKg: volume,
      totalSets: sets,
      totalReps: reps,
    );

    // Persist workout
    await _db.insertWorkout(completedWorkout);

    // Detect and save any PRs
    final List<PersonalRecord> newPrs = [];
    for (final ex in completedWorkout.exercises) {
      final prs = await _prService.checkAndRecordPrs(
        exercise: ex,
        workoutId: completedWorkout.id,
        timestamp: now,
      );
      newPrs.addAll(prs);
    }

    if (newPrs.isNotEmpty) {
      await SoundVibrationHelper.triggerPrVibration();
    }

    _activeWorkout = null;
    _elapsedSeconds = 0;
    notifyListeners();

    return newPrs;
  }

  void cancelWorkout() {
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
    _activeWorkout = null;
    _elapsedSeconds = 0;
    notifyListeners();
  }
}


// In-progress workout state persists throughout navigation lifecycle
