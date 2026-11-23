import 'package:flutter/material.dart';
import 'package:ironlog/utils/unit_converter.dart';
import 'package:ironlog/utils/app_theme.dart';

class VolumeChip extends StatelessWidget {
  final double volumeKg;
  final String unit;

  const VolumeChip({
    super.key,
    required this.volumeKg,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryOrange.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.fitness_center_rounded,
            size: 12,
            color: AppTheme.primaryOrangeLight,
          ),
          const SizedBox(width: 4),
          Text(
            UnitConverter.formatVolume(volumeKg, unit),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryOrangeLight,
            ),
          ),
        ],
      ),
    );
  }
}


// High contrast amber styling
