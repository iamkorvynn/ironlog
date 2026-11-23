class ValidationUtils {
  static String? validateExerciseName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Exercise name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (value.trim().length > 50) {
      return 'Name must be less than 50 characters';
    }
    return null;
  }

  static String? validateWeight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Weight required';
    }
    final parsed = double.tryParse(value.trim());
    if (parsed == null) {
      return 'Enter valid number';
    }
    if (parsed < 0) {
      return 'Cannot be negative';
    }
    if (parsed > 1000) {
      return 'Weight exceeds max limit';
    }
    return null;
  }

  static String? validateReps(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Reps required';
    }
    final parsed = int.tryParse(value.trim());
    if (parsed == null) {
      return 'Enter valid number';
    }
    if (parsed <= 0) {
      return 'Must be at least 1 rep';
    }
    if (parsed > 500) {
      return 'Reps exceed limit';
    }
    return null;
  }
}
