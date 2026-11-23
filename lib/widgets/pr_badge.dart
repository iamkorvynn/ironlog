import 'package:flutter/material.dart';
import 'package:ironlog/utils/app_theme.dart';

class PrBadge extends StatelessWidget {
  final String label;
  final bool isGold;
  final double fontSize;

  const PrBadge({
    super.key,
    required this.label,
    this.isGold = true,
    this.fontSize = 10,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isGold
        ? AppTheme.accentGold.withValues(alpha: 0.2)
        : AppTheme.accentGreen.withValues(alpha: 0.2);
    final fgColor = isGold ? AppTheme.accentGold : AppTheme.accentGreen;
    final borderColor = isGold
        ? AppTheme.accentGold.withValues(alpha: 0.4)
        : AppTheme.accentGreen.withValues(alpha: 0.4);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isGold ? Icons.emoji_events_rounded : Icons.flash_on_rounded,
            size: fontSize + 2,
            color: fgColor,
          ),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              color: fgColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
