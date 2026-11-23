import 'package:flutter/material.dart';
import 'package:ironlog/models/exercise.dart';
import 'package:ironlog/services/database_service.dart';
import 'package:ironlog/utils/constants.dart';
import 'package:ironlog/utils/validation_utils.dart';

/// Important rule adherence: Uses SingleChildScrollView + Column (NEVER ListView).
class AddCustomExerciseDialog extends StatefulWidget {
  const AddCustomExerciseDialog({super.key});

  @override
  State<AddCustomExerciseDialog> createState() =>
      _AddCustomExerciseDialogState();
}

class _AddCustomExerciseDialogState extends State<AddCustomExerciseDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  String _selectedMuscleGroup = 'Chest';
  final DatabaseService _db = DatabaseService();

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();
    final newEx = Exercise(
      id: 'custom_\${now.millisecondsSinceEpoch}',
      name: _nameController.text.trim(),
      muscleGroup: _selectedMuscleGroup,
      notes: _notesController.text.trim(),
      isCustom: true,
      createdAt: now,
    );

    await _db.insertExercise(newEx);
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final validMuscleGroups =
        AppConstants.muscleGroups.where((g) => g != 'All').toList();

    return AlertDialog(
      title: const Text('Add Custom Exercise'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Exercise Name',
                  hintText: 'e.g. Incline Dumbbell Press',
                ),
                validator: ValidationUtils.validateExerciseName,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedMuscleGroup,
                decoration: const InputDecoration(labelText: 'Muscle Group'),
                items: validMuscleGroups.map((group) {
                  return DropdownMenuItem(
                    value: group,
                    child: Text(group),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedMuscleGroup = val);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  hintText: 'Form cues, grip, equipment notes',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text('Save Exercise'),
        ),
      ],
    );
  }
}
