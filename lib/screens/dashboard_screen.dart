import 'package:flutter/material.dart';
import 'package:ironlog/models/workout_summary.dart';
import 'package:ironlog/models/personal_record.dart';
import 'package:ironlog/screens/active_workout_screen.dart';
import 'package:ironlog/screens/workout_detail_screen.dart';
import 'package:ironlog/services/active_workout_service.dart';
import 'package:ironlog/services/database_service.dart';
import 'package:ironlog/services/settings_service.dart';
import 'package:ironlog/services/stats_service.dart';
import 'package:ironlog/utils/app_theme.dart';
import 'package:ironlog/utils/unit_converter.dart';
import 'package:ironlog/widgets/metric_card.dart';
import 'package:ironlog/widgets/pr_badge.dart';
import 'package:ironlog/widgets/rest_day_card.dart';
import 'package:ironlog/widgets/workout_card.dart';

class DashboardScreen extends StatefulWidget {
  final ValueChanged<int> onNavigateToTab;

  const DashboardScreen({super.key, required this.onNavigateToTab});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DatabaseService _db = DatabaseService();
  final StatsService _statsService = StatsService();
  final SettingsService _settingsService = SettingsService();
  final ActiveWorkoutService _activeWorkoutService = ActiveWorkoutService();

  WorkoutSummary? _summary;
  List<PersonalRecord> _recentPrs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    _activeWorkoutService.addListener(_onActiveWorkoutChanged);
    _settingsService.addListener(_onSettingsChanged);
  }

  @override
  void dispose() {
    _activeWorkoutService.removeListener(_onActiveWorkoutChanged);
    _settingsService.removeListener(_onSettingsChanged);
    super.dispose();
  }

  void _onActiveWorkoutChanged() => setState(() {});
  void _onSettingsChanged() => setState(() {});

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final summary = await _statsService.getDashboardSummary();
    final allPrs = await _db.getAllPersonalRecords();
    setState(() {
      _summary = summary;
      _recentPrs = allPrs.take(5).toList();
      _isLoading = false;
    });
  }

  void _startNewWorkout() {
    _activeWorkoutService.startWorkout();
    Navigator.of(context)
        .push(
          MaterialPageRoute(builder: (_) => const ActiveWorkoutScreen()),
        )
        .then((_) => _loadData());
  }

  @override
  Widget build(BuildContext context) {
    final unit = _settingsService.weightUnit;
    final hasActive = _activeWorkoutService.hasActiveWorkout;

    return Scaffold(
      appBar: AppBar(
        title: const Text('IronLog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Active workout card banner if in progress
                    if (hasActive) ...[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryOrange.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppTheme.primaryOrange,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.play_circle_fill_rounded,
                              color: AppTheme.primaryOrange,
                              size: 32,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _activeWorkoutService.activeWorkout?.name ??
                                        'Workout in Progress',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Elapsed: \${UnitConverter.formatDuration(_activeWorkoutService.elapsedSeconds)}',
                                    style: const TextStyle(
                                      color: AppTheme.primaryOrangeLight,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const ActiveWorkoutScreen(),
                                      ),
                                    )
                                    .then((_) => _loadData());
                              },
                              child: const Text('Resume'),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      // Quick Start Workout button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _startNewWorkout,
                            icon: const Icon(Icons.add_rounded, size: 24),
                            label: const Text('START WORKOUT'),
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 8),

                    // Metrics row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: MetricCard(
                              title: 'This Week Vol',
                              value: UnitConverter.formatVolume(
                                _summary?.thisWeekVolumeKg ?? 0.0,
                                unit,
                              ),
                              subtitle:
                                  '\${_summary?.thisWeekWorkouts ?? 0} workouts',
                              icon: Icons.fitness_center_rounded,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: MetricCard(
                              title: 'Consistency',
                              value: '\${_summary?.activeStreakWeeks ?? 0} Wks',
                              subtitle: '\${_summary?.totalPrsCount ?? 0} PRs broken',
                              icon: Icons.local_fire_department_rounded,
                              iconColor: Colors.deepOrangeAccent,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Suggested rest day card
                    if (_summary != null)
                      RestDayCard(advice: _summary!.restDayAdvice),

                    const SizedBox(height: 16),

                    // Recent PRs section
                    if (_recentPrs.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Recent PRs',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () => widget.onNavigateToTab(2),
                              child: const Text('View All'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 90,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: _recentPrs.length,
                          itemBuilder: (context, i) {
                            final pr = _recentPrs[i];
                            return Container(
                              width: 160,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.darkSurface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppTheme.darkCardBorder),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          pr.exerciseName,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const PrBadge(label: 'PR'),
                                    ],
                                  ),
                                  Text(
                                    UnitConverter.formatWeight(
                                        pr.value, unit),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.accentGold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Last Workout Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Last Workout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (_summary?.lastWorkout != null)
                            TextButton(
                              onPressed: () => widget.onNavigateToTab(1),
                              child: const Text('History'),
                            ),
                        ],
                      ),
                    ),

                    if (_summary?.lastWorkout != null) ...[
                      WorkoutCard(
                        workout: _summary!.lastWorkout!,
                        unit: unit,
                        onTap: () {
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (_) => WorkoutDetailScreen(
                                    workoutId: _summary!.lastWorkout!.id,
                                  ),
                                ),
                              )
                              .then((_) => _loadData());
                        },
                      ),
                    ] else ...[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.darkSurface,
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: AppTheme.darkCardBorder),
                        ),
                        child: const Center(
                          child: Text(
                            'No workouts yet. Tap "START WORKOUT" above to log your first session!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }
}
