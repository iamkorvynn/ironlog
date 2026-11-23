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

  static String formatWeight(
    double weightKg,
    String unit, {
    bool includeUnit = true,
  }) {
    final val = displayWeight(weightKg, unit);
    final isInt = (val % 1 == 0);
    final formatted = isInt ? val.toStringAsFixed(0) : val.toStringAsFixed(1);
    if (!includeUnit) return formatted;
    return '$formatted ${unit.toLowerCase()}';
  }

  static String formatVolume(
    double volumeKg,
    String unit, {
    bool includeUnit = true,
  }) {
    final val = displayWeight(volumeKg, unit);
    final formatter = NumberFormat('#,##0');
    final formatted = formatter.format(val.round());
    if (!includeUnit) return formatted;
    return '$formatted ${unit.toLowerCase()}';
  }
}
