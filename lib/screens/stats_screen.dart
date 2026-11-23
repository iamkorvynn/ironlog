import 'package:flutter/material.dart';
import 'package:ironlog/models/exercise.dart';
import 'package:ironlog/models/exercise_progress_point.dart';
import 'package:ironlog/models/streak_info.dart';
import 'package:ironlog/models/weekly_stats.dart';
import 'package:ironlog/services/database_service.dart';
import 'package:ironlog/services/settings_service.dart';
import 'package:ironlog/services/stats_service.dart';
import 'package:ironlog/utils/app_theme.dart';
import 'package:ironlog/utils/unit_converter.dart';
import 'package:ironlog/widgets/custom_bar_chart.dart';
import 'package:ironlog/widgets/custom_line_chart.dart';
import 'package:ironlog/widgets/metric_card.dart';
import 'package:ironlog/widgets/streak_banner.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final DatabaseService _db = DatabaseService();
  final StatsService _statsService = StatsService();
  final SettingsService _settingsService = SettingsService();

  List<WeeklyStats> _weeklyStats = [];
  StreakInfo _streakInfo = StreakInfo.empty;
  List<Exercise> _exercises = [];
  Exercise? _selectedExercise;
  List<ExerciseProgressPoint> _exerciseProgress = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() => _isLoading = true);
    final history = await _db.getWeeklyStatsHistory(weeks: 8);
    final streak = await _statsService.getStreakInfo();
    final exList = await _db.getExercises();

    Exercise? selected;
    List<ExerciseProgressPoint> points = [];

    if (exList.isNotEmpty) {
      selected = exList.first;
      points = await _db.getExerciseProgress(selected.id);
    }

    setState(() {
      _weeklyStats = history;
      _streakInfo = streak;
      _exercises = exList;
      _selectedExercise = selected;
      _exerciseProgress = points;
      _isLoading = false;
    });
  }

  Future<void> _onExerciseChanged(Exercise? ex) async {
    if (ex == null) return;
    final points = await _db.getExerciseProgress(ex.id);
    setState(() {
      _selectedExercise = ex;
      _exerciseProgress = points;
    });
  }

  @override
  Widget build(BuildContext context) {
    final unit = _settingsService.weightUnit;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics & Stats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadStats,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreakBanner(streakInfo: _streakInfo),
                  const SizedBox(height: 12),

                  // Lifetime Metric cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: MetricCard(
                            title: 'Total Lifted',
                            value: UnitConverter.formatVolume(
                              _streakInfo.totalVolumeKg,
                              unit,
                            ),
                            icon: Icons.fitness_center,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MetricCard(
                            title: 'Workouts',
                            value: '\${_streakInfo.totalWorkouts}',
                            subtitle:
                                '\${_streakInfo.currentWeeklyStreak} week streak',
                            icon: Icons.calendar_month,
                            iconColor: Colors.tealAccent,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Weekly Volume Chart
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Weekly Volume History',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomBarChart(
                        data: _weeklyStats,
                        unit: unit,
                        height: 180,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Per-Exercise Progression
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Exercise Progression',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_exercises.isNotEmpty)
                          DropdownButton<Exercise>(
                            value: _selectedExercise,
                            underline: const SizedBox(),
                            items: _exercises.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e.name,
                                    style: const TextStyle(fontSize: 14)),
                              );
                            }).toList(),
                            onChanged: _onExerciseChanged,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomLineChart(
                        points: _exerciseProgress,
                        unit: unit,
                        height: 160,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
