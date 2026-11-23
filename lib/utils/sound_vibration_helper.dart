import 'package:flutter/services.dart';

class SoundVibrationHelper {
  static Future<void> triggerRestTimerVibration() async {
    try {
      await HapticFeedback.heavyImpact();
      await Future.delayed(const Duration(milliseconds: 300));
      await HapticFeedback.heavyImpact();
    } catch (_) {
      // Graceful fallback on unsupported platforms
    }
  }

  static Future<void> triggerPrVibration() async {
    try {
      await HapticFeedback.selectionClick();
      await Future.delayed(const Duration(milliseconds: 150));
      await HapticFeedback.heavyImpact();
    } catch (_) {
      // Graceful fallback
    }
  }

  static Future<void> triggerSetCompleteHaptic() async {
    try {
      await HapticFeedback.lightImpact();
    } catch (_) {
      // Graceful fallback
    }
  }
}
