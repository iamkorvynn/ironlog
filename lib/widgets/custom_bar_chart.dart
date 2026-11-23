import 'package:flutter/material.dart';
import 'package:ironlog/models/weekly_stats.dart';
import 'package:ironlog/utils/app_theme.dart';
import 'package:ironlog/utils/unit_converter.dart';

class CustomBarChart extends StatelessWidget {
  final List<WeeklyStats> data;
  final String unit;
  final double height;

  const CustomBarChart({
    super.key,
    required this.data,
    required this.unit,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(
          child: Text(
            'No volume data yet',
            style: TextStyle(color: AppTheme.textSecondary),
          ),
        ),
      );
    }

    double maxVal = 0.0;
    for (final d in data) {
      final disp = UnitConverter.displayWeight(d.totalVolumeKg, unit);
      if (disp > maxVal) maxVal = disp;
    }
    if (maxVal == 0) maxVal = 100;

    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.map((d) {
          final val = UnitConverter.displayWeight(d.totalVolumeKg, unit);
          final ratio = (val / maxVal).clamp(0.05, 1.0);
          final isCurrent = d == data.last;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (val > 0)
                    Text(
                      val >= 1000
                          ? '\${(val / 1000).toStringAsFixed(1)}k'
                          : val.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Container(
                    height: (height - 40) * ratio,
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? AppTheme.primaryOrange
                          : AppTheme.primaryOrange.withValues(alpha: 0.4),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'W\${d.weekStart.day}',
                    style: TextStyle(
                      fontSize: 10,
                      color: isCurrent ? Colors.white : AppTheme.textSecondary,
                      fontWeight:
                          isCurrent ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}


// Chart typography clarity
