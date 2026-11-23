import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/models/exercise.dart';
import 'package:ironlog/models/workout.dart';
import 'package:ironlog/models/streak_info.dart';
import 'package:ironlog/models/weekly_stats.dart';
import 'package:ironlog/models/exercise_progress_point.dart';
import 'package:ironlog/services/database_service.dart';
import 'package:ironlog/widgets/pr_badge.dart';
import 'package:ironlog/widgets/volume_chip.dart';
import 'package:ironlog/widgets/metric_card.dart';
import 'package:ironlog/widgets/empty_state_widget.dart';
import 'package:ironlog/widgets/confirm_dialog.dart';
import 'package:ironlog/widgets/unit_toggle_switch.dart';
import 'package:ironlog/widgets/exercise_card.dart';
import 'package:ironlog/widgets/workout_card.dart';
import 'package:ironlog/widgets/streak_banner.dart';
import 'package:ironlog/widgets/rest_day_card.dart';
import 'package:ironlog/widgets/custom_bar_chart.dart';
import 'package:ironlog/widgets/custom_line_chart.dart';
import 'package:ironlog/widgets/muscle_group_selector.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  setUp(() {
    DatabaseService().enableInMemoryMode();
  });

  group('PrBadge widget', () {
    testWidgets('renders PR label in gold mode', (tester) async {
      await tester.pumpWidget(_wrap(const PrBadge(label: '1RM PR')));
      expect(find.text('1RM PR'), findsOneWidget);
      expect(find.byIcon(Icons.emoji_events_rounded), findsOneWidget);
    });

    testWidgets('renders PR label in green mode', (tester) async {
      await tester.pumpWidget(_wrap(const PrBadge(label: 'MAX WT', isGold: false)));
      expect(find.text('MAX WT'), findsOneWidget);
      expect(find.byIcon(Icons.flash_on_rounded), findsOneWidget);
    });
  });

  group('VolumeChip widget', () {
    testWidgets('renders formatted volume with icon', (tester) async {
      await tester.pumpWidget(_wrap(const VolumeChip(volumeKg: 1500, unit: 'kg')));
      expect(find.text('1,500 kg'), findsOneWidget);
      expect(find.byIcon(Icons.fitness_center_rounded), findsOneWidget);
    });
  });

  group('MetricCard widget', () {
    testWidgets('displays title, value, and subtitle', (tester) async {
      await tester.pumpWidget(_wrap(
        const MetricCard(
          title: 'Total Volume',
          value: '45,000 kg',
          subtitle: '12 sessions',
          icon: Icons.fitness_center,
        ),
      ));
      expect(find.text('Total Volume'), findsOneWidget);
      expect(find.text('45,000 kg'), findsOneWidget);
      expect(find.text('12 sessions'), findsOneWidget);
    });
  });

  group('EmptyStateWidget', () {
    testWidgets('renders title, subtitle, and action button', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(_wrap(
        EmptyStateWidget(
          icon: Icons.fitness_center,
          title: 'No Workouts',
          subtitle: 'Start your journey now',
          buttonLabel: 'Add Workout',
          onButtonPressed: () => pressed = true,
        ),
      ));

      expect(find.text('No Workouts'), findsOneWidget);
      expect(find.text('Start your journey now'), findsOneWidget);
      expect(find.text('Add Workout'), findsOneWidget);

      await tester.tap(find.text('Add Workout'));
      expect(pressed, isTrue);
    });
  });

  group('ConfirmDialog widget', () {
    testWidgets('renders dialog and responds to cancel/confirm', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const ConfirmDialog(
                    title: 'Delete Item',
                    content: 'Confirm delete?',
                  ),
                );
              },
              child: const Text('Open'),
            );
          }),
        ),
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Delete Item'), findsOneWidget);
      expect(find.text('Confirm delete?'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
    });
  });

  group('UnitToggleSwitch widget', () {
    testWidgets('switches between kg and lbs', (tester) async {
      String selected = 'kg';
      await tester.pumpWidget(_wrap(
        StatefulBuilder(builder: (context, setState) {
          return UnitToggleSwitch(
            currentUnit: selected,
            onChanged: (u) => setState(() => selected = u),
          );
        }),
      ));

      expect(find.text('KG'), findsOneWidget);
      expect(find.text('LBS'), findsOneWidget);

      await tester.tap(find.text('LBS'));
      await tester.pumpAndSettle();
      expect(selected, 'lbs');
    });
  });

  group('ExerciseCard widget', () {
    testWidgets('displays exercise details and responds to tap', (tester) async {
      bool tapped = false;
      final ex = Exercise(
        id: 'e1',
        name: 'Overhead Press',
        muscleGroup: 'Shoulders',
        createdAt: DateTime.now(),
      );

      await tester.pumpWidget(_wrap(
        ExerciseCard(
          exercise: ex,
          unit: 'kg',
          onTap: () => tapped = true,
        ),
      ));

      expect(find.text('Overhead Press'), findsOneWidget);
      expect(find.text('Shoulders'), findsOneWidget);

      await tester.tap(find.text('Overhead Press'));
      expect(tapped, isTrue);
    });
  });

  group('WorkoutCard widget', () {
    testWidgets('displays past workout card summary', (tester) async {
      final w = Workout(
        id: 'w1',
        name: 'Full Body Push',
        startTime: DateTime.now(),
        durationSeconds: 3600,
        totalVolumeKg: 8500,
        totalSets: 12,
      );

      await tester.pumpWidget(_wrap(
        WorkoutCard(
          workout: w,
          unit: 'kg',
          onTap: () {},
        ),
      ));

      expect(find.text('Full Body Push'), findsOneWidget);
      expect(find.text('8,500 kg'), findsOneWidget);
      expect(find.text('12 sets'), findsOneWidget);
    });
  });

  group('StreakBanner widget', () {
    testWidgets('displays streak count and total workouts', (tester) async {
      const streak = StreakInfo(
        currentWeeklyStreak: 4,
        longestWeeklyStreak: 6,
        currentDayStreak: 2,
        totalWorkouts: 18,
        totalVolumeKg: 50000,
      );

      await tester.pumpWidget(_wrap(const StreakBanner(streakInfo: streak)));
      expect(find.text('4 Week Streak!'), findsOneWidget);
      expect(find.text('18 lifetime workouts logged'), findsOneWidget);
    });
  });

  group('RestDayCard widget', () {
    testWidgets('displays advice message', (tester) async {
      await tester.pumpWidget(_wrap(
        const RestDayCard(advice: 'Hydrate and get 8 hours of sleep.'),
      ));
      expect(find.text('Recovery & Suggestion'), findsOneWidget);
      expect(find.text('Hydrate and get 8 hours of sleep.'), findsOneWidget);
    });
  });

  group('CustomBarChart widget', () {
    testWidgets('renders bar chart without error', (tester) async {
      final data = [
        WeeklyStats(
          weekStart: DateTime.now().subtract(const Duration(days: 7)),
          weekEnd: DateTime.now(),
          totalVolumeKg: 4000,
          workoutCount: 3,
          totalSets: 12,
          totalReps: 100,
        ),
      ];

      await tester.pumpWidget(_wrap(
        CustomBarChart(data: data, unit: 'kg'),
      ));

      expect(find.byType(CustomBarChart), findsOneWidget);
    });
  });

  group('CustomLineChart widget', () {
    testWidgets('renders line chart with points', (tester) async {
      final points = [
        ExerciseProgressPoint(
          date: DateTime.now().subtract(const Duration(days: 7)),
          weightKg: 80,
          reps: 5,
          estimated1Rm: 93.3,
          workoutId: 'w1',
        ),
        ExerciseProgressPoint(
          date: DateTime.now(),
          weightKg: 85,
          reps: 5,
          estimated1Rm: 99.1,
          workoutId: 'w2',
        ),
      ];

      await tester.pumpWidget(_wrap(
        CustomLineChart(points: points, unit: 'kg'),
      ));

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });

  group('MuscleGroupSelector widget', () {
    testWidgets('renders filter chips and selects group', (tester) async {
      String selected = 'All';
      await tester.pumpWidget(_wrap(
        StatefulBuilder(builder: (context, setState) {
          return MuscleGroupSelector(
            selected: selected,
            onSelected: (g) => setState(() => selected = g),
          );
        }),
      ));

      expect(find.text('All'), findsOneWidget);
      expect(find.text('Chest'), findsOneWidget);
      expect(find.text('Legs'), findsOneWidget);

      await tester.tap(find.text('Chest'));
      await tester.pumpAndSettle();
      expect(selected, 'Chest');
    });
  });
}


  group('PrBadge - variants', () {
    testWidgets('renders custom font size', (tester) async {
      await tester.pumpWidget(_wrap(const PrBadge(label: 'NEW', fontSize: 14)));
      expect(find.text('NEW'), findsOneWidget);
    });
  });


  group('VolumeChip - lbs formatting', () {
    testWidgets('displays volume in lbs', (tester) async {
      await tester.pumpWidget(_wrap(const VolumeChip(volumeKg: 1000, unit: 'lbs')));
      expect(find.textContaining('lbs'), findsOneWidget);
    });
  });


  group('MetricCard - custom colors', () {
    testWidgets('renders custom icon color', (tester) async {
      await tester.pumpWidget(_wrap(
        const MetricCard(
          title: 'Streak',
          value: '5 Weeks',
          icon: Icons.local_fire_department,
          iconColor: Colors.deepOrange,
        ),
      ));
      expect(find.text('Streak'), findsOneWidget);
    });
  });


  group('EmptyStateWidget - without button', () {
    testWidgets('renders text only when buttonLabel is null', (tester) async {
      await tester.pumpWidget(_wrap(
        const EmptyStateWidget(
          icon: Icons.info,
          title: 'Info',
          subtitle: 'No items available',
        ),
      ));
      expect(find.text('Info'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
    });
  });
