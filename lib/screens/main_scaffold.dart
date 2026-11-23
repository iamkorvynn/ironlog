import 'package:flutter/material.dart';
import 'package:ironlog/screens/dashboard_screen.dart';
import 'package:ironlog/screens/workouts_screen.dart';
import 'package:ironlog/screens/exercises_screen.dart';
import 'package:ironlog/screens/stats_screen.dart';
import 'package:ironlog/screens/settings_screen.dart';
import 'package:ironlog/services/rest_timer_service.dart';
import 'package:ironlog/widgets/rest_timer_mini_bar.dart';

class MainScaffold extends StatefulWidget {
  final int initialIndex;

  const MainScaffold({super.key, this.initialIndex = 0});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void setTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(onNavigateToTab: setTab),
      const WorkoutsScreen(),
      const ExercisesScreen(),
      const StatsScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RestTimerMiniBar(timerService: RestTimerService()),
          NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: setTab,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              NavigationDestination(
                icon: Icon(Icons.fitness_center_outlined),
                selectedIcon: Icon(Icons.fitness_center),
                label: 'Workouts',
              ),
              NavigationDestination(
                icon: Icon(Icons.format_list_bulleted_outlined),
                selectedIcon: Icon(Icons.format_list_bulleted),
                label: 'Exercises',
              ),
              NavigationDestination(
                icon: Icon(Icons.bar_chart_outlined),
                selectedIcon: Icon(Icons.bar_chart),
                label: 'Stats',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
