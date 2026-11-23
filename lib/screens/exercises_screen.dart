import 'package:flutter/material.dart';
import 'package:ironlog/models/exercise.dart';
import 'package:ironlog/models/personal_record.dart';
import 'package:ironlog/screens/add_custom_exercise_dialog.dart';
import 'package:ironlog/screens/exercise_detail_screen.dart';
import 'package:ironlog/services/database_service.dart';
import 'package:ironlog/services/settings_service.dart';
import 'package:ironlog/utils/filter_utils.dart';
import 'package:ironlog/widgets/exercise_card.dart';
import 'package:ironlog/widgets/muscle_group_selector.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen>
    with SingleTickerProviderStateMixin {
  final DatabaseService _db = DatabaseService();
  final SettingsService _settingsService = SettingsService();

  late TabController _tabController;
  List<Exercise> _exercises = [];
  Map<String, PersonalRecord> _exercise1RmMap = {};
  List<PersonalRecord> _allPrs = [];
  String _selectedGroup = 'All';
  String _searchQuery = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final exList = await _db.getExercises();
    final prList = await _db.getAllPersonalRecords();

    final Map<String, PersonalRecord> prMap = {};
    for (final pr in prList) {
      if (pr.recordType == 'oneRepMax') {
        if (!prMap.containsKey(pr.exerciseId) ||
            pr.value > prMap[pr.exerciseId]!.value) {
          prMap[pr.exerciseId] = pr;
        }
      }
    }

    setState(() {
      _exercises = exList;
      _exercise1RmMap = prMap;
      _allPrs = prList;
      _isLoading = false;
    });
  }

  void _openAddDialog() async {
    final created = await showDialog<bool>(
      context: context,
      builder: (_) => const AddCustomExerciseDialog(),
    );
    if (created == true) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final unit = _settingsService.weightUnit;
    final filteredExercises = FilterUtils.filterExercises(
      exercises: _exercises,
      selectedMuscleGroup: _selectedGroup,
      searchQuery: _searchQuery,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises & PRs'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Library'),
            Tab(text: 'Personal Records'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. Library Tab
          Column(
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search library...',
                    prefixIcon: Icon(Icons.search),
                    isDense: true,
                  ),
                  onChanged: (val) => setState(() => _searchQuery = val),
                ),
              ),
              const SizedBox(height: 10),
              MuscleGroupSelector(
                selected: _selectedGroup,
                onSelected: (grp) => setState(() => _selectedGroup = grp),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: filteredExercises.length,
                        itemBuilder: (context, i) {
                          final ex = filteredExercises[i];
                          return ExerciseCard(
                            exercise: ex,
                            best1RmPr: _exercise1RmMap[ex.id],
                            unit: unit,
                            onTap: () {
                              Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                      builder: (_) => ExerciseDetailScreen(
                                        exercise: ex,
                                      ),
                                    ),
                                  )
                                  .then((_) => _loadData());
                            },
                          );
                        },
                      ),
              ),
            ],
          ),

          // 2. Personal Records Tab
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _allPrs.isEmpty
                  ? const Center(
                      child: Text(
                        'No personal records yet.\nLog completed workouts to earn PR badges!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, height: 1.5),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: _allPrs.length,
                      itemBuilder: (context, i) {
                        final pr = _allPrs[i];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.amber,
                              child: Icon(Icons.emoji_events, color: Colors.black),
                            ),
                            title: Text(
                              pr.exerciseName,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '\${pr.recordTypeLabel} • \${pr.reps} reps',
                            ),
                            trailing: Text(
                              '\${pr.value.toStringAsFixed(1)} $unit',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddDialog,
        tooltip: 'Add Custom Exercise',
        child: const Icon(Icons.add),
      ),
    );
  }
}
