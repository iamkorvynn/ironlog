import 'package:flutter/material.dart';
import 'package:ironlog/models/workout.dart';
import 'package:ironlog/screens/active_workout_screen.dart';
import 'package:ironlog/screens/workout_detail_screen.dart';
import 'package:ironlog/services/active_workout_service.dart';
import 'package:ironlog/services/database_service.dart';
import 'package:ironlog/services/settings_service.dart';
import 'package:ironlog/widgets/empty_state_widget.dart';
import 'package:ironlog/widgets/workout_card.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  final DatabaseService _db = DatabaseService();
  final SettingsService _settingsService = SettingsService();
  final ActiveWorkoutService _activeWorkoutService = ActiveWorkoutService();

  List<Workout> _workouts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    setState(() => _isLoading = true);
    final list = await _db.getWorkouts();
    setState(() {
      _workouts = list;
      _isLoading = false;
    });
  }

  void _startWorkout() {
    _activeWorkoutService.startWorkout();
    Navigator.of(context)
        .push(
          MaterialPageRoute(builder: (_) => const ActiveWorkoutScreen()),
        )
        .then((_) => _loadWorkouts());
  }

  @override
  Widget build(BuildContext context) {
    final unit = _settingsService.weightUnit;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadWorkouts,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _workouts.isEmpty
              ? EmptyStateWidget(
                  icon: Icons.fitness_center_rounded,
                  title: 'No Workouts Logged',
                  subtitle:
                      'Your workout sessions will appear here with duration, volume, and sets history.',
                  buttonLabel: 'Start First Workout',
                  onButtonPressed: _startWorkout,
                )
              : RefreshIndicator(
                  onRefresh: _loadWorkouts,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _workouts.length,
                    itemBuilder: (context, index) {
                      final w = _workouts[index];
                      return WorkoutCard(
                        workout: w,
                        unit: unit,
                        onTap: () {
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (_) => WorkoutDetailScreen(
                                    workoutId: w.id,
                                  ),
                                ),
                              )
                              .then((_) => _loadWorkouts());
                        },
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startWorkout,
        icon: const Icon(Icons.add),
        label: const Text('Start Workout'),
      ),
    );
  }
}
