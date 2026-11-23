class OneRepMaxCalculator {
  /// Epley Formula: weight * (1 + reps / 30.0)
  static double epley(double weight, int reps) {
    if (weight <= 0 || reps <= 0) return 0.0;
    if (reps == 1) return weight;
    return weight * (1.0 + (reps / 30.0));
  }

  /// Brzycki Formula: weight * (36.0 / (37.0 - reps))
  static double brzycki(double weight, int reps) {
    if (weight <= 0 || reps <= 0) return 0.0;
    if (reps == 1) return weight;
    final clampedReps = reps >= 37 ? 36 : reps;
    return weight * (36.0 / (37.0 - clampedReps));
  }

  /// Estimates the maximum weight for a target rep count given a 1RM.
  static double weightForReps(double oneRm, int targetReps) {
    if (oneRm <= 0 || targetReps <= 0) return 0.0;
    if (targetReps == 1) return oneRm;
    // Reverse of Epley: weight = 1RM / (1 + reps / 30.0)
    return oneRm / (1.0 + (targetReps / 30.0));
  }

  /// Generates a standard rep percentage table from 1 to 12 reps.
  static Map<int, double> repTable(double oneRm) {
    final Map<int, double> table = {};
    for (int reps = 1; reps <= 12; reps++) {
      table[reps] = weightForReps(oneRm, reps);
    }
    return table;
  }
}
