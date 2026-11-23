import 'package:flutter/material.dart';
import 'package:ironlog/models/exercise.dart';
import 'package:ironlog/screens/add_custom_exercise_dialog.dart';
import 'package:ironlog/services/database_service.dart';
import 'package:ironlog/utils/filter_utils.dart';
import 'package:ironlog/widgets/muscle_group_selector.dart';

class SelectExerciseModal extends StatefulWidget {
  final ValueChanged<Exercise> onExerciseSelected;

  const SelectExerciseModal({super.key, required this.onExerciseSelected});

  @override
  State<SelectExerciseModal> createState() => _SelectExerciseModalState();
}

class _SelectExerciseModalState extends State<SelectExerciseModal> {
  final DatabaseService _db = DatabaseService();

  List<Exercise> _allExercises = [];
  String _selectedGroup = 'All';
  String _searchQuery = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    setState(() => _isLoading = true);
    final list = await _db.getExercises();
    setState(() {
      _allExercises = list;
      _isLoading = false;
    });
  }

  void _openAddCustomDialog() async {
    final created = await showDialog<bool>(
      context: context,
      builder: (_) => const AddCustomExerciseDialog(),
    );
    if (created == true) {
      _loadExercises();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = FilterUtils.filterExercises(
      exercises: _allExercises,
      selectedMuscleGroup: _selectedGroup,
      searchQuery: _searchQuery,
    );

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Exercise',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                    onPressed: _openAddCustomDialog,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Custom'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search exercises...',
                  prefixIcon: Icon(Icons.search),
                  isDense: true,
                ),
                onChanged: (val) => setState(() => _searchQuery = val),
              ),
            ),
            const SizedBox(height: 12),
            MuscleGroupSelector(
              selected: _selectedGroup,
              onSelected: (group) => setState(() => _selectedGroup = group),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {
                        final ex = filtered[i];
                        return ListTile(
                          title: Text(
                            ex.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(ex.muscleGroup),
                          trailing: const Icon(Icons.add_circle_outline),
                          onTap: () {
                            widget.onExerciseSelected(ex);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}


// Dense search input
