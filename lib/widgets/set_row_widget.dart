import 'package:flutter/material.dart';
import 'package:ironlog/models/workout_set.dart';
import 'package:ironlog/utils/app_theme.dart';
import 'package:ironlog/utils/unit_converter.dart';

class SetRowWidget extends StatefulWidget {
  final WorkoutSet set;
  final String unit;
  final ValueChanged<WorkoutSet> onUpdate;
  final VoidCallback onToggleComplete;
  final VoidCallback onDelete;

  const SetRowWidget({
    super.key,
    required this.set,
    required this.unit,
    required this.onUpdate,
    required this.onToggleComplete,
    required this.onDelete,
  });

  @override
  State<SetRowWidget> createState() => _SetRowWidgetState();
}

class _SetRowWidgetState extends State<SetRowWidget> {
  late TextEditingController _weightController;
  late TextEditingController _repsController;

  @override
  void initState() {
    super.initState();
    final displayWt = UnitConverter.displayWeight(
      widget.set.weightKg,
      widget.unit,
    );
    _weightController = TextEditingController(
      text: displayWt > 0
          ? (displayWt % 1 == 0
              ? displayWt.toStringAsFixed(0)
              : displayWt.toStringAsFixed(1))
          : '',
    );
    _repsController = TextEditingController(
      text: widget.set.reps > 0 ? widget.set.reps.toString() : '',
    );
  }

  @override
  void didUpdateWidget(SetRowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.set.weightKg != widget.set.weightKg ||
        oldWidget.unit != widget.unit) {
      final displayWt = UnitConverter.displayWeight(
        widget.set.weightKg,
        widget.unit,
      );
      final newText = displayWt > 0
          ? (displayWt % 1 == 0
              ? displayWt.toStringAsFixed(0)
              : displayWt.toStringAsFixed(1))
          : '';
      if (_weightController.text != newText) {
        _weightController.text = newText;
      }
    }
    if (oldWidget.set.reps != widget.set.reps) {
      final newReps = widget.set.reps > 0 ? widget.set.reps.toString() : '';
      if (_repsController.text != newReps) {
        _repsController.text = newReps;
      }
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  void _onFieldsChanged() {
    final inputWt = double.tryParse(_weightController.text.trim()) ?? 0.0;
    final storedKg = UnitConverter.inputToKg(inputWt, widget.unit);
    final reps = int.tryParse(_repsController.text.trim()) ?? 0;

    widget.onUpdate(widget.set.copyWith(
      weightKg: storedKg,
      reps: reps,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isDone = widget.set.isCompleted;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDone
            ? AppTheme.accentGreen.withValues(alpha: 0.08)
            : AppTheme.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDone
              ? AppTheme.accentGreen.withValues(alpha: 0.3)
              : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          // Set index
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isDone
                  ? AppTheme.accentGreen.withValues(alpha: 0.2)
                  : AppTheme.darkCardBorder,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${widget.set.setOrder}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDone ? AppTheme.accentGreen : Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Weight input
          Expanded(
            flex: 3,
            child: TextField(
              controller: _weightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                isDense: true,
                hintText: '0',
                suffixText: widget.unit,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              onChanged: (_) => _onFieldsChanged(),
            ),
          ),
          const SizedBox(width: 8),
          // Reps input
          Expanded(
            flex: 2,
            child: TextField(
              controller: _repsController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                isDense: true,
                hintText: '0',
                suffixText: 'reps',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              onChanged: (_) => _onFieldsChanged(),
            ),
          ),
          const SizedBox(width: 8),
          // Checkmark toggle
          IconButton(
            icon: Icon(
              isDone ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
              color: isDone ? AppTheme.accentGreen : AppTheme.textSecondary,
              size: 26,
            ),
            onPressed: widget.onToggleComplete,
          ),
          // Delete
          IconButton(
            icon: const Icon(
              Icons.close,
              size: 18,
              color: AppTheme.textSecondary,
            ),
            onPressed: widget.onDelete,
          ),
        ],
      ),
    );
  }
}


// 48dp minimum accessible touch target
