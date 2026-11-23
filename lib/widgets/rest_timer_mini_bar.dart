import 'package:flutter/material.dart';
import 'package:ironlog/services/rest_timer_service.dart';
import 'package:ironlog/utils/app_theme.dart';
import 'package:ironlog/widgets/rest_timer_sheet.dart';

class RestTimerMiniBar extends StatelessWidget {
  final RestTimerService timerService;

  const RestTimerMiniBar({
    super.key,
    required this.timerService,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: timerService,
      builder: (context, _) {
        if (!timerService.isRunning) return const SizedBox.shrink();

        final state = timerService.state;

        return Material(
          elevation: 8,
          color: AppTheme.darkSurfaceElevated,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppTheme.darkSurface,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => RestTimerSheet(timerService: timerService),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppTheme.primaryOrange, width: 2),
                ),
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: state.progress,
                        strokeWidth: 3,
                        backgroundColor:
                            AppTheme.primaryOrange.withValues(alpha: 0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppTheme.primaryOrange,
                        ),
                      ),
                      const Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: AppTheme.primaryOrangeLight,
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Rest Timer',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      Text(
                        state.formattedRemaining,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      state.isPaused ? Icons.play_arrow : Icons.pause,
                      color: AppTheme.primaryOrange,
                    ),
                    onPressed: () {
                      if (state.isPaused) {
                        timerService.resume();
                      } else {
                        timerService.pause();
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppTheme.textSecondary),
                    onPressed: () => timerService.stop(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


// Elevation polish
