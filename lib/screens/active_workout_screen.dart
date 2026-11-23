import 'package:flutter/material.dart';
import 'package:ironlog/models/personal_record.dart';
import 'package:ironlog/screens/select_exercise_modal.dart';
import 'package:ironlog/services/active_workout_service.dart';
import 'package:ironlog/services/rest_timer_service.dart';
import 'package:ironlog/services/settings_service.dart';
import 'package:ironlog/utils/app_theme.dart';
import 'package:ironlog/utils/unit_converter.dart';
import 'package:ironlog/widgets/confirm_dialog.dart';
import 'package:ironlog/widgets/rest_timer_sheet.dart';
import 'package:ironlog/widgets/set_row_widget.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  final ActiveWorkoutService _service = ActiveWorkoutService();
  final SettingsService _settingsService = SettingsService();
  final RestTimerService _timerService = RestTimerService();

  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: _service.activeWorkout?.name ?? 'Workout',
    );
    _service.addListener(_onServiceUpdate);
  }

  @override
  void dispose() {
    _service.removeListener(_onServiceUpdate);
    _titleController.dispose();
    super.dispose();
  }

  void _onServiceUpdate() {
    if (mounted) setState(() {});
  }

  void _openAddExerciseModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SelectExerciseModal(
        onExerciseSelected: (ex) {
          _service.addExercise(ex);
        },
      ),
    );
  }

  void _openTimerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => RestTimerSheet(timerService: _timerService),
    );
  }

  Future<void> _cancelWorkout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmDialog(
        title: 'Discard Workout',
        content: 'Are you sure you want to discard this workout? All progress will be lost.',
        confirmLabel: 'Discard',
        isDestructive: true,
      ),
    );

    if (confirm == true && mounted) {
      _service.cancelWorkout();
      Navigator.of(context).pop();
    }
  }

  Future<void> _finishWorkout() async {
    final workout = _service.activeWorkout;
    if (workout == null) return;

    if (workout.calculateTotalSets() == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complete at least one set before finishing.')),
      );
      return;
    }

    final newPrs = await _service.finishWorkout();

    if (mounted) {
      if (newPrs.isNotEmpty) {
        await _showPrCelebrationDialog(newPrs);
      }
      if (mounted) Navigator.of(context).pop();
    }
  }

  Future<void> _showPrCelebrationDialog(List<PersonalRecord> prs) async {
    final unit = _settingsService.weightUnit;
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.emoji_events_rounded, color: AppTheme.accentGold),
            SizedBox(width: 8),
            Text('PRs Broken!'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: prs.map((pr) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  '🏆 \${pr.exerciseName}: \${UnitConverter.formatWeight(pr.value, unit)} (\${pr.recordTypeLabel})',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Awesome!'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workout = _service.activeWorkout;
    final unit = _settingsService.weightUnit;

    if (workout == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Active Workout')),
        body: const Center(child: Text('No active workout session.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _titleController,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (val) => _service.updateWorkoutName(val),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.timer_outlined, color: AppTheme.primaryOrange),
            onPressed: _openTimerSheet,
          ),
          TextButton(
            onPressed: _cancelWorkout,
            child: const Text('Cancel', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.darkSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.darkCardBorder),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer_rounded,
                          size: 16, color: AppTheme.primaryOrangeLight),
                      const SizedBox(width: 6),
                      Text(
                        UnitConverter.formatDuration(_service.elapsedSeconds),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Volume: \${UnitConverter.formatVolume(workout.calculateTotalVolume(), unit)}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryOrangeLight,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Exercises
            ...workout.exercises.map((we) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              we.exerciseName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_vert,
                                color: AppTheme.textSecondary),
                            onPressed: () => _service.removeExercise(we.id),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Sets
                      ...we.sets.map((s) {
                        return SetRowWidget(
                          set: s,
                          unit: unit,
                          onUpdate: (updatedSet) {
                            _service.updateSet(
                              we.id,
                              s.id,
                              weightKg: updatedSet.weightKg,
                              reps: updatedSet.reps,
                            );
                          },
                          onToggleComplete: () {
                            _service.toggleSetCompleted(we.id, s.id);
                          },
                          onDelete: () {
                            _service.removeSet(we.id, s.id);
                          },
                        );
                      }),
                      const SizedBox(height: 8),
                      Center(
                        child: OutlinedButton.icon(
                          onPressed: () => _service.addSet(we.id),
                          icon: const Icon(Icons.add, size: 16),
                          label: const Text('Add Set'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _openAddExerciseModal,
                icon: const Icon(Icons.add),
                label: const Text('Add Exercise'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppTheme.darkSurface,
          border: Border(top: BorderSide(color: AppTheme.darkCardBorder)),
        ),
        child: ElevatedButton(
          onPressed: _finishWorkout,
          child: const Text('FINISH WORKOUT'),
        ),
      ),
    );
  }
}
