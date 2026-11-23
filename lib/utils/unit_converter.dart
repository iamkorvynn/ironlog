import 'package:intl/intl.dart';

class UnitConverter {
  static const double kgToLbsFactor = 2.20462262;

  static double kgToLbs(double kg) => kg * kgToLbsFactor;
  static double lbsToKg(double lbs) => lbs / kgToLbsFactor;
}
