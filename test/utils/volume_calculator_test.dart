import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/models/workout.dart';
import 'package:ironlog/models/workout_exercise.dart';
import 'package:ironlog/models/workout_set.dart';
import 'package:ironlog/utils/volume_calculator.dart';

void main() {
  group('VolumeCalculator - calculateSetVolume', () {
    test('calculates volume for completed set', () {
      const set = WorkoutSet(
        id: 's1',
        workoutExerciseId: 'we1',
        setOrder: 1,
        weightKg: 100,
        reps: 10,
        isCompleted: true,
      );
      expect(VolumeCalculator.calculateSetVolume(set), 1000.0);
    });

    test('returns 0 for uncompleted set', () {
      const set = WorkoutSet(
        id: 's1',
        workoutExerciseId: 'we1',
        setOrder: 1,
        weightKg: 100,
        reps: 10,
        isCompleted: false,
      );
      expect(VolumeCalculator.calculateSetVolume(set), 0.0);
    });

    test('returns 0 for 0 weight set (e.g. bodyweight pullups without added weight)', () {
      const set = WorkoutSet(
        id: 's1',
        workoutExerciseId: 'we1',
        setOrder: 1,
        weightKg: 0,
        reps: 10,
        isCompleted: true,
      );
      expect(VolumeCalculator.calculateSetVolume(set), 0.0);
    });

    test('returns 0 for 0 reps', () {
      const set = WorkoutSet(
        id: 's1',
        workoutExerciseId: 'we1',
        setOrder: 1,
        weightKg: 80,
        reps: 0,
        isCompleted: true,
      );
      expect(VolumeCalculator.calculateSetVolume(set), 0.0);
    });
  });

  group('VolumeCalculator - calculateExerciseVolume', () {
    test('sums all completed sets in an exercise', () {
      const ex = WorkoutExercise(
        id: 'we1',
        workoutId: 'w1',
        exerciseId: 'ex1',
        exerciseName: 'Bench Press',
        muscleGroup: 'Chest',
        orderIndex: 0,
        sets: [
          WorkoutSet(
            id: 's1',
            workoutExerciseId: 'we1',
            setOrder: 1,
            weightKg: 60,
            reps: 10,
            isCompleted: true,
          ),
          WorkoutSet(
            id: 's2',
            workoutExerciseId: 'we1',
            setOrder: 2,
            weightKg: 80,
            reps: 8,
            isCompleted: true,
          ),
          WorkoutSet(
            id: 's3',
            workoutExerciseId: 'we1',
            setOrder: 3,
            weightKg: 100,
            reps: 5,
            isCompleted: false, // skipped or not done
          ),
        ],
      );
      // 60*10 = 600, 80*8 = 640 -> 1240
      expect(VolumeCalculator.calculateExerciseVolume(ex), 1240.0);
    });

    test('returns 0 for empty sets list', () {
      const ex = WorkoutExercise(
        id: 'we1',
        workoutId: 'w1',
        exerciseId: 'ex1',
        exerciseName: 'Squat',
        muscleGroup: 'Legs',
        orderIndex: 0,
        sets: [],
      );
      expect(VolumeCalculator.calculateExerciseVolume(ex), 0.0);
    });
  });

  group('VolumeCalculator - calculateWorkoutVolume and aggregations', () {
    final workout = Workout(
      id: 'w1',
      name: 'Leg Day',
      startTime: DateTime(2026, 11, 23, 10, 0),
      exercises: const [
        WorkoutExercise(
          id: 'we1',
          workoutId: 'w1',
          exerciseId: 'e1',
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
              isCompleted: true,
            ),
            WorkoutSet(
              id: 's2',
              workoutExerciseId: 'we1',
              setOrder: 2,
              weightKg: 100,
              reps: 5,
              isCompleted: true,
            ),
          ],
        ),
        WorkoutExercise(
          id: 'we2',
          workoutId: 'w1',
          exerciseId: 'e2',
          exerciseName: 'Leg Press',
          muscleGroup: 'Legs',
          orderIndex: 1,
          sets: [
            WorkoutSet(
              id: 's3',
              workoutExerciseId: 'we2',
              setOrder: 1,
              weightKg: 200,
              reps: 10,
              isCompleted: true,
            ),
          ],
        ),
      ],
    );

    test('calculates total workout volume (1000 + 2000 = 3000)', () {
      expect(VolumeCalculator.calculateWorkoutVolume(workout), 3000.0);
    });

    test('calculates total completed sets count (3)', () {
      expect(VolumeCalculator.calculateTotalCompletedSets(workout), 3);
    });

    test('calculates total reps (5 + 5 + 10 = 20)', () {
      expect(VolumeCalculator.calculateTotalReps(workout), 20);
    });
  });
}
