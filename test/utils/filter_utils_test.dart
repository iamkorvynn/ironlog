import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/models/exercise.dart';
import 'package:ironlog/utils/filter_utils.dart';

void main() {
  final exercises = [
    Exercise(
      id: 'e1',
      name: 'Bench Press',
      muscleGroup: 'Chest',
      createdAt: DateTime(2026, 11, 23),
    ),
    Exercise(
      id: 'e2',
      name: 'Incline Dumbbell Press',
      muscleGroup: 'Chest',
      createdAt: DateTime(2026, 11, 23),
    ),
    Exercise(
      id: 'e3',
      name: 'Squat',
      muscleGroup: 'Legs',
      createdAt: DateTime(2026, 11, 23),
    ),
    Exercise(
      id: 'e4',
      name: 'Deadlift',
      muscleGroup: 'Back',
      createdAt: DateTime(2026, 11, 23),
    ),
  ];

  group('FilterUtils', () {
    test('All muscle group and empty query returns all exercises', () {
      final res = FilterUtils.filterExercises(
        exercises: exercises,
        selectedMuscleGroup: 'All',
        searchQuery: '',
      );
      expect(res.length, 4);
    });

    test('filters by specific muscle group', () {
      final res = FilterUtils.filterExercises(
        exercises: exercises,
        selectedMuscleGroup: 'Chest',
        searchQuery: '',
      );
      expect(res.length, 2);
      expect(res.every((e) => e.muscleGroup == 'Chest'), isTrue);
    });

    test('filters by search query case-insensitively', () {
      final res = FilterUtils.filterExercises(
        exercises: exercises,
        selectedMuscleGroup: 'All',
        searchQuery: 'bench',
      );
      expect(res.length, 1);
      expect(res.first.name, 'Bench Press');
    });

    test('combines muscle group and search query', () {
      final res = FilterUtils.filterExercises(
        exercises: exercises,
        selectedMuscleGroup: 'Chest',
        searchQuery: 'incline',
      );
      expect(res.length, 1);
      expect(res.first.name, 'Incline Dumbbell Press');
    });

    test('returns empty when no match', () {
      final res = FilterUtils.filterExercises(
        exercises: exercises,
        selectedMuscleGroup: 'Arms',
        searchQuery: 'curl',
      );
      expect(res.isEmpty, isTrue);
    });
  });
}
