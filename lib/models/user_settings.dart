class UserSettings {
  final String weightUnit; // 'kg' or 'lbs'
  final int defaultRestDurationSeconds;
  final String themeMode; // 'system', 'dark', 'light'
  final bool vibrateOnRestEnd;
  final bool soundOnRestEnd;
  final bool autoStartRestTimer;

  const UserSettings({
    this.weightUnit = 'kg',
    this.defaultRestDurationSeconds = 60,
    this.themeMode = 'dark',
    this.vibrateOnRestEnd = true,
    this.soundOnRestEnd = true,
    this.autoStartRestTimer = true,
  });

  bool get isKg => weightUnit == 'kg';
  bool get isLbs => weightUnit == 'lbs';

  UserSettings copyWith({
    String? weightUnit,
    int? defaultRestDurationSeconds,
    String? themeMode,
    bool? vibrateOnRestEnd,
    bool? soundOnRestEnd,
    bool? autoStartRestTimer,
  }) {
    return UserSettings(
      weightUnit: weightUnit ?? this.weightUnit,
      defaultRestDurationSeconds:
          defaultRestDurationSeconds ?? this.defaultRestDurationSeconds,
      themeMode: themeMode ?? this.themeMode,
      vibrateOnRestEnd: vibrateOnRestEnd ?? this.vibrateOnRestEnd,
      soundOnRestEnd: soundOnRestEnd ?? this.soundOnRestEnd,
      autoStartRestTimer: autoStartRestTimer ?? this.autoStartRestTimer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weight_unit': weightUnit,
      'default_rest_duration_seconds': defaultRestDurationSeconds,
      'theme_mode': themeMode,
      'vibrate_on_rest_end': vibrateOnRestEnd ? 1 : 0,
      'sound_on_rest_end': soundOnRestEnd ? 1 : 0,
      'auto_start_rest_timer': autoStartRestTimer ? 1 : 0,
    };
  }

  factory UserSettings.fromMap(Map<String, dynamic> map) {
    return UserSettings(
      weightUnit: (map['weight_unit'] as String?) ?? 'kg',
      defaultRestDurationSeconds:
          (map['default_rest_duration_seconds'] as int?) ?? 60,
      themeMode: (map['theme_mode'] as String?) ?? 'dark',
      vibrateOnRestEnd: (map['vibrate_on_rest_end'] as int?) != 0,
      soundOnRestEnd: (map['sound_on_rest_end'] as int?) != 0,
      autoStartRestTimer: (map['auto_start_rest_timer'] as int?) != 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettings &&
          runtimeType == other.runtimeType &&
          weightUnit == other.weightUnit &&
          defaultRestDurationSeconds == other.defaultRestDurationSeconds &&
          themeMode == other.themeMode &&
          vibrateOnRestEnd == other.vibrateOnRestEnd &&
          soundOnRestEnd == other.soundOnRestEnd &&
          autoStartRestTimer == other.autoStartRestTimer;

  @override
  int get hashCode =>
      weightUnit.hashCode ^
      defaultRestDurationSeconds.hashCode ^
      themeMode.hashCode ^
      vibrateOnRestEnd.hashCode ^
      soundOnRestEnd.hashCode ^
      autoStartRestTimer.hashCode;
}


// Immutable model verified
