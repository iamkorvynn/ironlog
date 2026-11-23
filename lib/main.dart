import 'package:flutter/material.dart';
import 'package:ironlog/screens/main_scaffold.dart';
import 'package:ironlog/services/database_service.dart';
import 'package:ironlog/services/notification_service.dart';
import 'package:ironlog/services/settings_service.dart';
import 'package:ironlog/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local notifications safely
  await NotificationService().initialize();

  // Initialize SQLite database
  await DatabaseService().database;

  // Load user settings
  final settingsService = SettingsService();
  await settingsService.loadSettings();

  runApp(const IronLogApp());
}

class IronLogApp extends StatelessWidget {
  const IronLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: SettingsService(),
      builder: (context, _) {
        final themeMode = SettingsService().themeMode;
        ThemeMode mode;
        if (themeMode == 'light') {
          mode = ThemeMode.light;
        } else if (themeMode == 'dark') {
          mode = ThemeMode.dark;
        } else {
          mode = ThemeMode.dark; // Default dark
        }

        return MaterialApp(
          title: 'IronLog',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          home: const MainScaffold(),
        );
      },
    );
  }
}
