import 'package:flutter/material.dart';
import 'package:ironlog/utils/app_theme.dart';

class UnitToggleSwitch extends StatelessWidget {
  final String currentUnit;
  final ValueChanged<String> onChanged;

  const UnitToggleSwitch({
    super.key,
    required this.currentUnit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(value: 'kg', label: Text('KG')),
        ButtonSegment(value: 'lbs', label: Text('LBS')),
      ],
      selected: {currentUnit.toLowerCase()},
      onSelectionChanged: (set) {
        if (set.isNotEmpty) {
          onChanged(set.first);
        }
      },
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: AppTheme.primaryOrange,
        selectedForegroundColor: Colors.black,
      ),
    );
  }
}
