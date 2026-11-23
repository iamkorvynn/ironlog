import 'package:flutter/material.dart';
import 'package:ironlog/models/exercise.dart';
import 'package:ironlog/models/exercise_progress_point.dart';
import 'package:ironlog/models/personal_record.dart';
import 'package:ironlog/services/database_service.dart';
import 'package:ironlog/services/settings_service.dart';
import 'package:ironlog/utils/app_theme.dart';
import 'package:ironlog/utils/unit_converter.dart';
import 'package:ironlog/widgets/confirm_dialog.dart';
import 'package:ironlog/widgets/custom_line_chart.dart';
import 'package:ironlog/widgets/pr_badge.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDetailScreen({super.key, required this.exercise});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  final DatabaseService _db = DatabaseService();
  final SettingsService _settingsService = SettingsService();

  List<PersonalRecord> _prs = [];
  List<ExerciseProgressPoint> _progressPoints = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    setState(() => _isLoading = true);
    final prs = await _db.getPersonalRecordsByExercise(widget.exercise.id);
    final points = await _db.getExerciseProgress(widget.exercise.id);

    setState(() {
      _prs = prs;
      _progressPoints = points;
      _isLoading = false;
    });
  }

  Future<void> _deleteExercise() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmDialog(
        title: 'Delete Exercise',
        content: 'Delete this custom exercise? Past workouts referencing it will remain.',
        confirmLabel: 'Delete',
        isDestructive: true,
      ),
    );

    if (confirm == true && mounted) {
      await _db.deleteExercise(widget.exercise.id);
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final unit = _settingsService.weightUnit;
    final ex = widget.exercise;

    return Scaffold(
      appBar: AppBar(
        title: Text(ex.name),
        actions: [
          if (ex.isCustom)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: _deleteExercise,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header badge
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryOrange.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          ex.muscleGroup,
                          style: const TextStyle(
                            color: AppTheme.primaryOrangeLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (ex.isCustom) ...[
                        const SizedBox(width: 8),
                        const Chip(label: Text('Custom')),
                      ],
                    ],
                  ),
                  if (ex.notes.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      ex.notes,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),
                  const Text(
                    '1RM Progress Curve',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // Line Chart
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomLineChart(
                        points: _progressPoints,
                        unit: unit,
                        height: 160,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Personal Records',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  if (_prs.isEmpty) ...[
                    const Text(
                      'No PRs yet for this exercise.',
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                  ] else ...[
                    ..._prs.map((pr) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const PrBadge(label: 'PR'),
                          title: Text(
                            pr.recordTypeLabel,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Achieved on \${UnitConverter.formatDate(pr.achievedAt)}',
                          ),
                          trailing: Text(
                            UnitConverter.formatWeight(pr.value, unit),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.accentGold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
    );
  }
}
