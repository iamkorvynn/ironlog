import 'package:intl/intl.dart';

class UnitConverter {
  static const double kgToLbsFactor = 2.20462262;

  static double kgToLbs(double kg) => kg * kgToLbsFactor;
  static double lbsToKg(double lbs) => lbs / kgToLbsFactor;

  /// Converts a stored kg value to the display value in the chosen unit.
  static double displayWeight(double weightKg, String unit) {
    if (unit.toLowerCase() == 'lbs') {
      return kgToLbs(weightKg);
    }
    return weightKg;
  }

  /// Converts an input weight value in [unit] back to standard stored kg.
  static double inputToKg(double inputWeight, String unit) {
    if (unit.toLowerCase() == 'lbs') {
      return lbsToKg(inputWeight);
    }
    return inputWeight;
  }

  /// Formats weight with appropriate decimals (e.g., "100 kg" or "220.5 lbs").
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

  /// Formats volume with compact notation (e.g. "5,200 kg" or "11,464 lbs").
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

  /// Formats duration in seconds to "HH:MM:SS" or "MM:SS" or verbal "1h 24m".
  static String formatDuration(int seconds, {bool verbal = false}) {
    if (seconds <= 0) return verbal ? '0m' : '00:00';
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;

    if (verbal) {
      if (h > 0) {
        return '${h}h ${m}m';
      }
      return '${m}m';
    }

    final mStr = m.toString().padLeft(2, '0');
    final sStr = s.toString().padLeft(2, '0');

    if (h > 0) {
      final hStr = h.toString().padLeft(2, '0');
      return '$hStr:$mStr:$sStr';
    }
    return '$mStr:$sStr';
  }

  /// Formats a DateTime into a friendly date header.
  static String formatDate(DateTime dt) {
    return DateFormat('EEE, d MMM yyyy').format(dt);
  }

  /// Formats a DateTime relative to today.
  static String formatRelativeDate(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dt.year, dt.month, dt.day);
    final diff = today.difference(date).inDays;

    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7 && diff > 1) return '$diff days ago';
    return DateFormat('d MMM yyyy').format(dt);
  }
}


// Performance optimized conversions


// 1 kg = 2.20462262 lbs exact NIST conversion factor
