import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ironlog/services/database_service.dart';
import 'package:ironlog/services/settings_service.dart';
import 'package:ironlog/utils/constants.dart';
import 'package:ironlog/widgets/confirm_dialog.dart';
import 'package:ironlog/widgets/unit_toggle_switch.dart';

/// Form Bug Avoidance Rule: Uses SingleChildScrollView + Column (NEVER ListView for forms).
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsService _settingsService = SettingsService();
  final DatabaseService _db = DatabaseService();

  @override
  void initState() {
    super.initState();
    _settingsService.addListener(_onSettingsUpdated);
  }

  @override
  void dispose() {
    _settingsService.removeListener(_onSettingsUpdated);
    super.dispose();
  }

  void _onSettingsUpdated() {
    if (mounted) setState(() {});
  }

  Future<void> _exportData() async {
    final export = await _db.exportData();
    final jsonStr = jsonEncode(export.toJson());
    if (mounted) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Export Data (JSON)'),
          content: SingleChildScrollView(
            child: SelectableText(
              jsonStr,
              style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _clearAllData() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmDialog(
        title: 'Clear All Data',
        content:
            'This will permanently remove all workouts, PRs, and custom exercises. Built-in exercises will be retained. Proceed?',
        confirmLabel: 'Clear All',
        isDestructive: true,
      ),
    );

    if (confirm == true && mounted) {
      await _db.clearAllData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All user data cleared.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = _settingsService.settings;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Units & Measurements',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Weight Unit',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    UnitToggleSwitch(
                      currentUnit: settings.weightUnit,
                      onChanged: (u) => _settingsService.setWeightUnit(u),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Rest Timer Defaults',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Default Rest Duration'),
                        DropdownButton<int>(
                          value: settings.defaultRestDurationSeconds,
                          items: AppConstants.defaultRestPresets.map((sec) {
                            return DropdownMenuItem(
                              value: sec,
                              child: Text('\${sec}s'),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              _settingsService.setDefaultRestSeconds(val);
                            }
                          },
                        ),
                      ],
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Vibrate when Rest Ends'),
                      value: settings.vibrateOnRestEnd,
                      onChanged: (val) =>
                          _settingsService.toggleVibration(val),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Notification Sound'),
                      value: settings.soundOnRestEnd,
                      onChanged: (val) => _settingsService.toggleSound(val),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Data Management',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.download),
                    title: const Text('Export Backup (JSON)'),
                    onTap: _exportData,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
                    title: const Text(
                      'Clear All Data',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    onTap: _clearAllData,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            Center(
              child: Column(
                children: [
                  Text(
                    '\${AppConstants.appName} v\${AppConstants.appVersion}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Local-only gym tracker • Built for peak performance',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
