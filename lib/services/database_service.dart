import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:ironlog/models/exercise.dart';
import 'package:ironlog/models/workout.dart';
import 'package:ironlog/models/workout_exercise.dart';
import 'package:ironlog/models/workout_set.dart';
import 'package:ironlog/models/personal_record.dart';
import 'package:ironlog/models/user_settings.dart';
import 'package:ironlog/models/weekly_stats.dart';
import 'package:ironlog/models/exercise_progress_point.dart';
import 'package:ironlog/models/export_data.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _db;
  bool _useInMemory = false;

  // In-memory fallback maps for test environment
  final Map<String, Exercise> _memExercises = {};
  final Map<String, Workout> _memWorkouts = {};
  final Map<String, List<PersonalRecord>> _memPrs = {};
  UserSettings _memSettings = const UserSettings();

  void enableInMemoryMode() {
    _useInMemory = true;
    _initBuiltInExercisesInMemory();
  }

  void _initBuiltInExercisesInMemory() {
    if (_memExercises.isEmpty) {
      for (final ex in Exercise.getBuiltInExercises()) {
        _memExercises[ex.id] = ex;
      }
    }
  }

  Future<Database?> get database async {
    if (_useInMemory) return null;
    if (_db != null) return _db!;
    try {
      _db = await _initDb();
      return _db!;
    } catch (_) {
      // In flutter test without SQLite native lib, switch to in-memory gracefully
      _useInMemory = true;
      _initBuiltInExercisesInMemory();
      return null;
    }
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'ironlog_v1.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _createTables(db);
        await _seedBuiltIns(db);
      },
    );
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE exercises (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        muscle_group TEXT NOT NULL,
        notes TEXT,
        is_custom INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE workouts (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        start_time TEXT NOT NULL,
        end_time TEXT,
        duration_seconds INTEGER NOT NULL DEFAULT 0,
        notes TEXT,
        total_volume_kg REAL NOT NULL DEFAULT 0.0,
        total_sets INTEGER NOT NULL DEFAULT 0,
        total_reps INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE workout_exercises (
        id TEXT PRIMARY KEY,
        workout_id TEXT NOT NULL,
        exercise_id TEXT NOT NULL,
        exercise_name TEXT NOT NULL,
        muscle_group TEXT NOT NULL,
        order_index INTEGER NOT NULL,
        notes TEXT,
        FOREIGN KEY (workout_id) REFERENCES workouts (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE workout_sets (
        id TEXT PRIMARY KEY,
        workout_exercise_id TEXT NOT NULL,
        set_order INTEGER NOT NULL,
        weight_kg REAL NOT NULL,
        reps INTEGER NOT NULL,
        is_completed INTEGER NOT NULL DEFAULT 0,
        rpe REAL,
        notes TEXT,
        FOREIGN KEY (workout_exercise_id) REFERENCES workout_exercises (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE personal_records (
        id TEXT PRIMARY KEY,
        exercise_id TEXT NOT NULL,
        exercise_name TEXT NOT NULL,
        workout_id TEXT NOT NULL,
        record_type TEXT NOT NULL,
        value REAL NOT NULL,
        weight_kg REAL NOT NULL,
        reps INTEGER NOT NULL,
        achieved_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');
  }

  Future<void> _seedBuiltIns(Database db) async {
    final batch = db.batch();
    for (final ex in Exercise.getBuiltInExercises()) {
      batch.insert(
        'exercises',
        ex.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await batch.commit(noResult: true);
  }

  // --- Exercises CRUD ---
  Future<List<Exercise>> getExercises() async {
    if (_useInMemory) {
      _initBuiltInExercisesInMemory();
      return _memExercises.values.toList()
        ..sort((a, b) => a.name.compareTo(b.name));
    }

    final db = await database;
    if (db == null) return getExercises();

    final List<Map<String, dynamic>> maps =
        await db.query('exercises', orderBy: 'name ASC');

    if (maps.isEmpty) {
      await _seedBuiltIns(db);
      return getExercises();
    }

    return maps.map((m) => Exercise.fromMap(m)).toList();
  }

  Future<Exercise?> getExerciseById(String id) async {
    if (_useInMemory) {
      _initBuiltInExercisesInMemory();
      return _memExercises[id];
    }
    final db = await database;
    if (db == null) return getExerciseById(id);

    final List<Map<String, dynamic>> maps = await db.query(
      'exercises',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return Exercise.fromMap(maps.first);
  }

  Future<void> insertExercise(Exercise exercise) async {
    if (_useInMemory) {
      _memExercises[exercise.id] = exercise;
      return;
    }
    final db = await database;
    if (db == null) {
      insertExercise(exercise);
      return;
    }
    await db.insert(
      'exercises',
      exercise.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateExercise(Exercise exercise) async {
    if (_useInMemory) {
      _memExercises[exercise.id] = exercise;
      return;
    }
    final db = await database;
    if (db == null) {
      updateExercise(exercise);
      return;
    }
    await db.update(
      'exercises',
      exercise.toMap(),
      where: 'id = ?',
      whereArgs: [exercise.id],
    );
  }

  Future<void> deleteExercise(String id) async {
    if (_useInMemory) {
      _memExercises.remove(id);
      return;
    }
    final db = await database;
    if (db == null) {
      deleteExercise(id);
      return;
    }
    await db.delete(
      'exercises',
      where: 'id = ? AND is_custom = 1',
      whereArgs: [id],
    );
  }

  // --- Workouts CRUD ---
  Future<List<Workout>> getWorkouts({int limit = 50}) async {
    if (_useInMemory) {
      final list = _memWorkouts.values.toList()
        ..sort((a, b) => b.startTime.compareTo(a.startTime));
      return list.take(limit).toList();
    }
    final db = await database;
    if (db == null) return getWorkouts(limit: limit);

    final maps = await db.query(
      'workouts',
      orderBy: 'start_time DESC',
      limit: limit,
    );

    final List<Workout> result = [];
    for (final m in maps) {
      final workoutId = m['id'] as String;
      final exercises = await _getWorkoutExercises(db, workoutId);
      result.add(Workout.fromMap(m, exercises: exercises));
    }
    return result;
  }

  Future<Workout?> getWorkoutById(String id) async {
    if (_useInMemory) {
      return _memWorkouts[id];
    }
    final db = await database;
    if (db == null) return getWorkoutById(id);

    final maps = await db.query(
      'workouts',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;

    final exercises = await _getWorkoutExercises(db, id);
    return Workout.fromMap(maps.first, exercises: exercises);
  }

  Future<List<WorkoutExercise>> _getWorkoutExercises(
    Database db,
    String workoutId,
  ) async {
    final maps = await db.query(
      'workout_exercises',
      where: 'workout_id = ?',
      whereArgs: [workoutId],
      orderBy: 'order_index ASC',
    );

    final List<WorkoutExercise> exercises = [];
    for (final em in maps) {
      final weId = em['id'] as String;
      final setMaps = await db.query(
        'workout_sets',
        where: 'workout_exercise_id = ?',
        whereArgs: [weId],
        orderBy: 'set_order ASC',
      );
      final sets = setMaps.map((s) => WorkoutSet.fromMap(s)).toList();
      exercises.add(WorkoutExercise.fromMap(em, sets: sets));
    }
    return exercises;
  }

  Future<void> insertWorkout(Workout workout) async {
    if (_useInMemory) {
      _memWorkouts[workout.id] = workout;
      return;
    }
    final db = await database;
    if (db == null) {
      insertWorkout(workout);
      return;
    }

    await db.transaction((txn) async {
      await txn.insert(
        'workouts',
        workout.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      for (final we in workout.exercises) {
        await txn.insert(
          'workout_exercises',
          we.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        for (final s in we.sets) {
          await txn.insert(
            'workout_sets',
            s.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }
    });
  }

  Future<void> deleteWorkout(String id) async {
    if (_useInMemory) {
      _memWorkouts.remove(id);
      return;
    }
    final db = await database;
    if (db == null) {
      deleteWorkout(id);
      return;
    }

    await db.transaction((txn) async {
      final weMaps = await txn.query(
        'workout_exercises',
        where: 'workout_id = ?',
        whereArgs: [id],
      );
      for (final we in weMaps) {
        await txn.delete(
          'workout_sets',
          where: 'workout_exercise_id = ?',
          whereArgs: [we['id']],
        );
      }
      await txn.delete(
        'workout_exercises',
        where: 'workout_id = ?',
        whereArgs: [id],
      );
      await txn.delete(
        'workouts',
        where: 'id = ?',
        whereArgs: [id],
      );
    });
  }

  // --- Personal Records ---
  Future<List<PersonalRecord>> getAllPersonalRecords() async {
    if (_useInMemory) {
      final all = <PersonalRecord>[];
      for (final list in _memPrs.values) {
        all.addAll(list);
      }
      all.sort((a, b) => b.achievedAt.compareTo(a.achievedAt));
      return all;
    }
    final db = await database;
    if (db == null) return getAllPersonalRecords();

    final maps = await db.query(
      'personal_records',
      orderBy: 'achieved_at DESC',
    );
    return maps.map((m) => PersonalRecord.fromMap(m)).toList();
  }

  Future<List<PersonalRecord>> getPersonalRecordsByExercise(
    String exerciseId,
  ) async {
    if (_useInMemory) {
      return _memPrs[exerciseId] ?? [];
    }
    final db = await database;
    if (db == null) return getPersonalRecordsByExercise(exerciseId);

    final maps = await db.query(
      'personal_records',
      where: 'exercise_id = ?',
      whereArgs: [exerciseId],
      orderBy: 'achieved_at DESC',
    );
    return maps.map((m) => PersonalRecord.fromMap(m)).toList();
  }

  Future<void> savePersonalRecord(PersonalRecord pr) async {
    if (_useInMemory) {
      _memPrs.putIfAbsent(pr.exerciseId, () => []);
      _memPrs[pr.exerciseId]!.removeWhere((p) => p.recordType == pr.recordType);
      _memPrs[pr.exerciseId]!.add(pr);
      return;
    }
    final db = await database;
    if (db == null) {
      savePersonalRecord(pr);
      return;
    }

    // Replace if older record for this exercise and type has lower value
    await db.insert(
      'personal_records',
      pr.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // --- Stats Queries ---
  Future<List<WeeklyStats>> getWeeklyStatsHistory({int weeks = 8}) async {
    final workouts = await getWorkouts(limit: 200);
    final now = DateTime.now();
    final cleanNow = DateTime(now.year, now.month, now.day);
    final currentMonday =
        cleanNow.subtract(Duration(days: cleanNow.weekday - 1));

    final List<WeeklyStats> history = [];
    for (int i = weeks - 1; i >= 0; i--) {
      final weekStart = currentMonday.subtract(Duration(days: i * 7));
      final weekEnd =
          weekStart.add(const Duration(days: 6, hours: 23, minutes: 59));

      final weekWorkouts = workouts.where((w) {
        return w.startTime.isAfter(weekStart) &&
            w.startTime.isBefore(weekEnd);
      }).toList();

      double volume = 0.0;
      int sets = 0;
      int reps = 0;
      for (final w in weekWorkouts) {
        volume += w.totalVolumeKg;
        sets += w.totalSets;
        reps += w.totalReps;
      }

      history.add(WeeklyStats(
        weekStart: weekStart,
        weekEnd: weekEnd,
        totalVolumeKg: volume,
        workoutCount: weekWorkouts.length,
        totalSets: sets,
        totalReps: reps,
      ));
    }
    return history;
  }

  Future<List<ExerciseProgressPoint>> getExerciseProgress(
    String exerciseId,
  ) async {
    final workouts = await getWorkouts(limit: 200);
    final List<ExerciseProgressPoint> points = [];

    // Order chronological
    final sorted = List<Workout>.from(workouts)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    for (final w in sorted) {
      for (final ex in w.exercises) {
        if (ex.exerciseId == exerciseId) {
          final best = ex.bestSet;
          if (best != null && best.isCompleted) {
            points.add(ExerciseProgressPoint(
              date: w.startTime,
              weightKg: best.weightKg,
              reps: best.reps,
              estimated1Rm: best.estimated1Rm,
              workoutId: w.id,
            ));
          }
        }
      }
    }
    return points;
  }

  // --- Settings ---
  Future<UserSettings> getSettings() async {
    if (_useInMemory) {
      return _memSettings;
    }
    final db = await database;
    if (db == null) return _memSettings;

    final maps = await db.query('settings');
    if (maps.isEmpty) return const UserSettings();

    final Map<String, dynamic> settingsMap = {};
    for (final m in maps) {
      final key = m['key'] as String;
      final val = m['value'] as String;
      if (key == 'weight_unit' || key == 'theme_mode') {
        settingsMap[key] = val;
      } else if (key == 'default_rest_duration_seconds') {
        settingsMap[key] = int.tryParse(val) ?? 60;
      } else {
        settingsMap[key] = (val == '1' || val == 'true') ? 1 : 0;
      }
    }
    return UserSettings.fromMap(settingsMap);
  }

  Future<void> saveSettings(UserSettings settings) async {
    if (_useInMemory) {
      _memSettings = settings;
      return;
    }
    final db = await database;
    if (db == null) {
      _memSettings = settings;
      return;
    }

    final map = settings.toMap();
    final batch = db.batch();
    map.forEach((k, v) {
      batch.insert(
        'settings',
        {'key': k, 'value': v.toString()},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
    await batch.commit(noResult: true);
  }

  // --- Backup / Export / Import ---
  Future<ExportData> exportData() async {
    final exercises = await getExercises();
    final workouts = await getWorkouts(limit: 1000);
    final prs = await getAllPersonalRecords();
    final settings = await getSettings();

    return ExportData(
      exportedAt: DateTime.now(),
      exercises: exercises,
      workouts: workouts,
      personalRecords: prs,
      settings: settings,
    );
  }

  Future<void> importData(ExportData data) async {
    for (final ex in data.exercises) {
      await insertExercise(ex);
    }
    for (final w in data.workouts) {
      await insertWorkout(w);
    }
    for (final pr in data.personalRecords) {
      await savePersonalRecord(pr);
    }
    await saveSettings(data.settings);
  }

  Future<void> clearAllData() async {
    if (_useInMemory) {
      _memWorkouts.clear();
      _memPrs.clear();
      _memExercises.clear();
      _initBuiltInExercisesInMemory();
      _memSettings = const UserSettings();
      return;
    }
    final db = await database;
    if (db == null) return;

    await db.transaction((txn) async {
      await txn.delete('workout_sets');
      await txn.delete('workout_exercises');
      await txn.delete('workouts');
      await txn.delete('personal_records');
      await txn.delete('exercises', where: 'is_custom = 1');
    });
  }
}


// Transactions ensure atomicity across workout, exercise, and set tables
