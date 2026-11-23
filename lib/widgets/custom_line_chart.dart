import 'package:flutter/material.dart';
import 'package:ironlog/models/exercise_progress_point.dart';
import 'package:ironlog/utils/app_theme.dart';
import 'package:ironlog/utils/unit_converter.dart';

class CustomLineChart extends StatelessWidget {
  final List<ExerciseProgressPoint> points;
  final String unit;
  final double height;

  const CustomLineChart({
    super.key,
    required this.points,
    required this.unit,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    if (points.length < 2) {
      return SizedBox(
        height: height,
        child: const Center(
          child: Text(
            'Log at least 2 sessions to see progress curve',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: CustomPaint(
        size: Size.infinite,
        painter: _LineChartPainter(points: points, unit: unit),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<ExerciseProgressPoint> points;
  final String unit;

  _LineChartPainter({required this.points, required this.unit});

  @override
  void paint(Canvas canvas, Size size) {
    final values = points
        .map((p) => UnitConverter.displayWeight(p.estimated1Rm, unit))
        .toList();

    double minVal = values.reduce((a, b) => a < b ? a : b);
    double maxVal = values.reduce((a, b) => a > b ? a : b);
    if (maxVal == minVal) {
      minVal -= 5;
      maxVal += 5;
    }

    final double padding = 20;
    final double chartWidth = size.width - (padding * 2);
    final double chartHeight = size.height - (padding * 2);

    final linePaint = Paint()
      ..color = AppTheme.primaryOrange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()
      ..color = AppTheme.accentGold
      ..style = PaintingStyle.fill;

    final path = Path();
    final List<Offset> offsets = [];

    for (int i = 0; i < points.length; i++) {
      final x = padding + (i / (points.length - 1)) * chartWidth;
      final normalizedY = (values[i] - minVal) / (maxVal - minVal);
      final y = size.height - padding - (normalizedY * chartHeight);
      final pt = Offset(x, y);
      offsets.add(pt);

      if (i == 0) {
        path.moveTo(pt.dx, pt.dy);
      } else {
        path.lineTo(pt.dx, pt.dy);
      }
    }

    canvas.drawPath(path, linePaint);

    for (final pt in offsets) {
      canvas.drawCircle(pt, 5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) => true;
}


// Anti-aliased canvas rendering
