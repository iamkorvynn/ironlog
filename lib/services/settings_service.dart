import 'package:flutter/foundation.dart';
import 'package:ironlog/models/user_settings.dart';
import 'package:ironlog/services/database_service.dart';

class SettingsService extends ChangeNotifier {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  final DatabaseService _db = DatabaseService();
  UserSettings _settings = const UserSettings();
  bool _isLoaded = false;

  UserSettings get settings => _settings;
  String get weightUnit => _settings.weightUnit;
  bool get isKg => _settings.isKg;
  bool get isLbs => _settings.isLbs;
  int get defaultRestSeconds => _settings.defaultRestDurationSeconds;
  String get themeMode => _settings.themeMode;
  bool get vibrateOnRestEnd => _settings.vibrateOnRestEnd;
  bool get soundOnRestEnd => _settings.soundOnRestEnd;

  Future<void> loadSettings() async {
    if (_isLoaded) return;
    _settings = await _db.getSettings();
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> setWeightUnit(String unit) async {
    if (_settings.weightUnit == unit) return;
    _settings = _settings.copyWith(weightUnit: unit);
    notifyListeners();
    await _db.saveSettings(_settings);
  }

  Future<void> setDefaultRestSeconds(int seconds) async {
    _settings = _settings.copyWith(defaultRestDurationSeconds: seconds);
    notifyListeners();
    await _db.saveSettings(_settings);
  }

  Future<void> setThemeMode(String mode) async {
    _settings = _settings.copyWith(themeMode: mode);
    notifyListeners();
    await _db.saveSettings(_settings);
  }

  Future<void> toggleVibration(bool enabled) async {
    _settings = _settings.copyWith(vibrateOnRestEnd: enabled);
    notifyListeners();
    await _db.saveSettings(_settings);
  }

  Future<void> toggleSound(bool enabled) async {
    _settings = _settings.copyWith(soundOnRestEnd: enabled);
    notifyListeners();
    await _db.saveSettings(_settings);
  }

  Future<void> updateSettings(UserSettings newSettings) async {
    _settings = newSettings;
    notifyListeners();
    await _db.saveSettings(_settings);
  }
}
