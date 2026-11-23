import 'package:flutter/material.dart';
import 'package:ironlog/models/workout.dart';
import 'package:ironlog/utils/app_theme.dart';
import 'package:ironlog/utils/unit_converter.dart';
import 'package:ironlog/widgets/volume_chip.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final String unit;
  final VoidCallback onTap;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.unit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final exercisesSummary = workout.exercises
        .map((e) => e.exerciseName)
        .take(3)
        .join(', ');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      workout.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    UnitConverter.formatRelativeDate(workout.startTime),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              if (exercisesSummary.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  exercisesSummary +
                      (workout.exercises.length > 3
                          ? ' + \${workout.exercises.length - 3} more'
                          : ''),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  VolumeChip(volumeKg: workout.totalVolumeKg, unit: unit),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.darkCardBorder,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.timer_outlined,
                            size: 12, color: AppTheme.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          UnitConverter.formatDuration(
                            workout.durationSeconds,
                            verbal: true,
                          ),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.darkCardBorder,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '\${workout.totalSets} sets',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Exercise summary tags layout
