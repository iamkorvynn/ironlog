import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      const androidInit =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const initSettings = InitializationSettings(android: androidInit);

      await _notificationsPlugin.initialize(settings: initSettings);
      _isInitialized = true;
    } catch (_) {
      // In tests or headless environments, initialization can fail safely
    }
  }

  Future<void> showRestTimerCompleteNotification({
    String title = 'Rest Finished!',
    String body = 'Time for your next set. Push through!',
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'rest_timer_channel',
        'Rest Timer Alerts',
        channelDescription: 'Notifications for workout set rest timers',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
      );

      const details = NotificationDetails(android: androidDetails);
      await _notificationsPlugin.show(
        id: 101,
        title: title,
        body: body,
        notificationDetails: details,
      );
    } catch (_) {
      // Safe fallback
    }
  }

  Future<void> cancelNotifications() async {
    try {
      await _notificationsPlugin.cancel(id: 101);
    } catch (_) {
      // Safe fallback
    }
  }
}


// Channel rest_timer_channel configured with High importance for timer alerts
