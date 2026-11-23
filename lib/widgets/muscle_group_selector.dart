import 'package:flutter/material.dart';
import 'package:ironlog/utils/constants.dart';
import 'package:ironlog/utils/app_theme.dart';

class MuscleGroupSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const MuscleGroupSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: AppConstants.muscleGroups.map((group) {
          final isSelected = group == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(group),
              selected: isSelected,
              onSelected: (_) => onSelected(group),
              selectedColor: AppTheme.primaryOrange,
              labelStyle: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
