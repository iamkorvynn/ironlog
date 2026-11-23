import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:ironlog/models/rest_timer_state.dart';
import 'package:ironlog/services/notification_service.dart';
import 'package:ironlog/utils/sound_vibration_helper.dart';

class RestTimerService extends ChangeNotifier {
  static final RestTimerService _instance = RestTimerService._internal();
  factory RestTimerService() => _instance;
  RestTimerService._internal();

  Timer? _timer;
  RestTimerState _state = RestTimerState.initial;
  bool _enableVibration = true;
  bool _enableSound = true;

  RestTimerState get state => _state;
  bool get isRunning => _state.isRunning;
  bool get isPaused => _state.isPaused;
  int get remainingSeconds => _state.remainingSeconds;
  int get totalSeconds => _state.totalSeconds;

  void configure({required bool vibrate, required bool sound}) {
    _enableVibration = vibrate;
    _enableSound = sound;
  }

  void start(int seconds) {
    _timer?.cancel();
    _state = RestTimerState(
      totalSeconds: seconds,
      remainingSeconds: seconds,
      isRunning: true,
      isPaused: false,
    );
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_state.remainingSeconds > 1) {
        _state = _state.copyWith(
          remainingSeconds: _state.remainingSeconds - 1,
        );
        notifyListeners();
      } else {
        _onFinished();
      }
    });
  }

  void pause() {
    if (!_state.isRunning || _state.isPaused) return;
    _timer?.cancel();
    _state = _state.copyWith(isPaused: true);
    notifyListeners();
  }

  void resume() {
    if (!_state.isRunning || !_state.isPaused) return;
    _state = _state.copyWith(isPaused: false);
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_state.remainingSeconds > 1) {
        _state = _state.copyWith(
          remainingSeconds: _state.remainingSeconds - 1,
        );
        notifyListeners();
      } else {
        _onFinished();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _state = RestTimerState.initial;
    notifyListeners();
  }

  void addSeconds(int seconds) {
    if (!_state.isRunning) return;
    final updatedRemaining = _state.remainingSeconds + seconds;
    final updatedTotal = _state.totalSeconds + (seconds > 0 ? seconds : 0);
    if (updatedRemaining <= 0) {
      _onFinished();
    } else {
      _state = _state.copyWith(
        remainingSeconds: updatedRemaining,
        totalSeconds: updatedTotal,
      );
      notifyListeners();
    }
  }

  Future<void> _onFinished() async {
    _timer?.cancel();
    _timer = null;
    _state = _state.copyWith(
      remainingSeconds: 0,
      isRunning: false,
      isPaused: false,
    );
    notifyListeners();

    if (_enableVibration) {
      await SoundVibrationHelper.triggerRestTimerVibration();
    }
    if (_enableSound) {
      await NotificationService().showRestTimerCompleteNotification();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
