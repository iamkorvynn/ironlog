class RestTimerState {
  final int totalSeconds;
  final int remainingSeconds;
  final bool isRunning;
  final bool isPaused;

  const RestTimerState({
    required this.totalSeconds,
    required this.remainingSeconds,
    this.isRunning = false,
    this.isPaused = false,
  });

  static const initial = RestTimerState(
    totalSeconds: 60,
    remainingSeconds: 60,
    isRunning: false,
    isPaused: false,
  );

  bool get isFinished => remainingSeconds <= 0 && isRunning;

  double get progress {
    if (totalSeconds <= 0) return 0.0;
    return (totalSeconds - remainingSeconds) / totalSeconds;
  }

  String get formattedRemaining {
    final m = remainingSeconds ~/ 60;
    final s = remainingSeconds % 60;
    final mStr = m.toString().padLeft(2, '0');
    final sStr = s.toString().padLeft(2, '0');
    return '$mStr:$sStr';
  }

  RestTimerState copyWith({
    int? totalSeconds,
    int? remainingSeconds,
    bool? isRunning,
    bool? isPaused,
  }) {
    return RestTimerState(
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
      isPaused: isPaused ?? this.isPaused,
    );
  }
}


// Immutable model verified
