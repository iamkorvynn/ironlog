import 'package:flutter/material.dart';
import 'package:ironlog/services/rest_timer_service.dart';
import 'package:ironlog/utils/app_theme.dart';
import 'package:ironlog/utils/constants.dart';

class RestTimerSheet extends StatelessWidget {
  final RestTimerService timerService;

  const RestTimerSheet({
    super.key,
    required this.timerService,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: timerService,
      builder: (context, _) {
        final state = timerService.state;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.darkCardBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Rest Timer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                // Circular countdown display
                SizedBox(
                  width: 160,
                  height: 160,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: CircularProgressIndicator(
                          value: state.isRunning ? state.progress : 1.0,
                          strokeWidth: 8,
                          backgroundColor:
                              AppTheme.primaryOrange.withValues(alpha: 0.15),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppTheme.primaryOrange,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.isRunning
                                ? state.formattedRemaining
                                : '00:00',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Text(
                            state.isPaused ? 'PAUSED' : 'RESTING',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.primaryOrangeLight,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Quick add / subtract
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => timerService.addSeconds(-15),
                      child: const Text('-15s'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (state.isPaused) {
                          timerService.resume();
                        } else if (state.isRunning) {
                          timerService.pause();
                        } else {
                          timerService.start(60);
                        }
                      },
                      child: Text(
                        state.isPaused
                            ? 'Resume'
                            : (state.isRunning ? 'Pause' : 'Start 60s'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () => timerService.addSeconds(15),
                      child: const Text('+15s'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Presets
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Presets',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  children: AppConstants.defaultRestPresets.map((sec) {
                    return ActionChip(
                      label: Text('\${sec}s'),
                      onPressed: () => timerService.start(sec),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
