import 'package:intl/intl.dart';

class UnitConverter {
  static const double kgToLbsFactor = 2.20462262;

  static double kgToLbs(double kg) => kg * kgToLbsFactor;
  static double lbsToKg(double lbs) => lbs / kgToLbsFactor;

  static double displayWeight(double weightKg, String unit) {
    if (unit.toLowerCase() == 'lbs') {
      return kgToLbs(weightKg);
    }
    return weightKg;
  }

  static double inputToKg(double inputWeight, String unit) {
    if (unit.toLowerCase() == 'lbs') {
      return lbsToKg(inputWeight);
    }
    return inputWeight;
  }
}
