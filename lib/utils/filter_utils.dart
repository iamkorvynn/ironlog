import 'package:ironlog/models/exercise.dart';

class FilterUtils {
  static List<Exercise> filterExercises({
    required List<Exercise> exercises,
    required String selectedMuscleGroup,
    required String searchQuery,
  }) {
    return exercises.where((ex) {
      final matchesGroup = selectedMuscleGroup == 'All' ||
          ex.muscleGroup.toLowerCase() == selectedMuscleGroup.toLowerCase();

      final matchesQuery = searchQuery.isEmpty ||
          ex.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          ex.muscleGroup.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesGroup && matchesQuery;
    }).toList();
  }
}
