import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/screens/main_scaffold.dart';
import 'package:ironlog/screens/dashboard_screen.dart';
import 'package:ironlog/screens/workouts_screen.dart';
import 'package:ironlog/screens/exercises_screen.dart';
import 'package:ironlog/screens/stats_screen.dart';
import 'package:ironlog/screens/settings_screen.dart';
import 'package:ironlog/screens/add_custom_exercise_dialog.dart';
import 'package:ironlog/services/database_service.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: child,
    );

void main() {
  setUp(() {
    DatabaseService().enableInMemoryMode();
  });

  group('MainScaffold navigation', () {
    testWidgets('renders NavigationBar destinations and switches tabs', (tester) async {
      await tester.pumpWidget(_wrap(const MainScaffold()));
      await tester.pumpAndSettle();

      expect(find.text('Dashboard'), findsWidgets);
      expect(find.text('Workouts'), findsOneWidget);
      expect(find.text('Exercises'), findsOneWidget);
      expect(find.text('Stats'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);

      // Tap Workouts tab
      await tester.tap(find.text('Workouts'));
      await tester.pumpAndSettle();
      expect(find.text('Workout History'), findsOneWidget);

      // Tap Exercises tab
      await tester.tap(find.text('Exercises'));
      await tester.pumpAndSettle();
      expect(find.text('Exercises & PRs'), findsOneWidget);

      // Tap Stats tab
      await tester.tap(find.text('Stats'));
      await tester.pumpAndSettle();
      expect(find.text('Analytics & Stats'), findsOneWidget);

      // Tap Settings tab
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();
      expect(find.text('Units & Measurements'), findsOneWidget);
    });
  });

  group('DashboardScreen widget', () {
    testWidgets('renders start workout button and metric cards', (tester) async {
      await tester.pumpWidget(_wrap(DashboardScreen(onNavigateToTab: (_) {})));
      await tester.pumpAndSettle();

      expect(find.text('IronLog'), findsOneWidget);
      expect(find.text('START WORKOUT'), findsOneWidget);
      expect(find.text('This Week Vol'), findsOneWidget);
      expect(find.text('Consistency'), findsOneWidget);
    });
  });

  group('WorkoutsScreen widget', () {
    testWidgets('renders empty state when no history exists', (tester) async {
      await tester.pumpWidget(_wrap(const WorkoutsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('No Workouts Logged'), findsOneWidget);
      expect(find.text('Start First Workout'), findsOneWidget);
    });
  });

  group('ExercisesScreen widget', () {
    testWidgets('renders Library and PRs tabs and lists built-in exercises', (tester) async {
      await tester.pumpWidget(_wrap(const ExercisesScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Library'), findsOneWidget);
      expect(find.text('Personal Records'), findsOneWidget);
      expect(find.text('Bench Press'), findsOneWidget);
      expect(find.text('Squat'), findsOneWidget);
      expect(find.text('Deadlift'), findsOneWidget);
    });
  });

  group('AddCustomExerciseDialog form', () {
    testWidgets('validates required name field before save', (tester) async {
      await tester.pumpWidget(_wrap(const AddCustomExerciseDialog()));
      await tester.pumpAndSettle();

      expect(find.text('Add Custom Exercise'), findsOneWidget);
      expect(find.text('Save Exercise'), findsOneWidget);

      await tester.tap(find.text('Save Exercise'));
      await tester.pumpAndSettle();

      expect(find.text('Exercise name is required'), findsOneWidget);
    });
  });

  group('StatsScreen widget', () {
    testWidgets('renders analytics headers and streak banner', (tester) async {
      await tester.pumpWidget(_wrap(const StatsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Analytics & Stats'), findsOneWidget);
      expect(find.text('Weekly Volume History'), findsOneWidget);
      expect(find.text('Exercise Progression'), findsOneWidget);
    });
  });

  group('SettingsScreen widget', () {
    testWidgets('renders unit switch, rest presets, and data options', (tester) async {
      await tester.pumpWidget(_wrap(const SettingsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Units & Measurements'), findsOneWidget);
      expect(find.text('Weight Unit'), findsOneWidget);
      expect(find.text('Rest Timer Defaults'), findsOneWidget);
      expect(find.text('Data Management'), findsOneWidget);
      expect(find.text('Export Backup (JSON)'), findsOneWidget);
      expect(find.text('Clear All Data'), findsOneWidget);
    });
  });
}


  group('DashboardScreen - quick start', () {
    testWidgets('has Start Workout button enabled', (tester) async {
      await tester.pumpWidget(_wrap(DashboardScreen(onNavigateToTab: (_) {})));
      await tester.pumpAndSettle();
      expect(find.text('START WORKOUT'), findsOneWidget);
    });
  });


  group('WorkoutsScreen - app bar', () {
    testWidgets('renders refresh action button', (tester) async {
      await tester.pumpWidget(_wrap(const WorkoutsScreen()));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });
  });


  group('ExercisesScreen - search bar', () {
    testWidgets('contains search text field', (tester) async {
      await tester.pumpWidget(_wrap(const ExercisesScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
    });
  });


  group('AddCustomExerciseDialog - muscle group selector', () {
    testWidgets('has muscle group dropdown with default Chest', (tester) async {
      await tester.pumpWidget(_wrap(const AddCustomExerciseDialog()));
      await tester.pumpAndSettle();
      expect(find.text('Chest'), findsOneWidget);
    });
  });


  group('StatsScreen - metrics', () {
    testWidgets('displays Total Lifted metric card', (tester) async {
      await tester.pumpWidget(_wrap(const StatsScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Total Lifted'), findsOneWidget);
      expect(find.text('Workouts'), findsOneWidget);
    });
  });


  group('SettingsScreen - rest presets', () {
    testWidgets('displays default rest duration dropdown', (tester) async {
      await tester.pumpWidget(_wrap(const SettingsScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Default Rest Duration'), findsOneWidget);
    });
  });


  group('SettingsScreen - vibration switch', () {
    testWidgets('displays vibration toggle switch', (tester) async {
      await tester.pumpWidget(_wrap(const SettingsScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Vibrate when Rest Ends'), findsOneWidget);
    });
  });
