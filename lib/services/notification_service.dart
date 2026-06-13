import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/models.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(initSettings);
    await _requestPermissions();
  }

  static Future<void> _requestPermissions() async {
    await _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  }

  static Future<void> scheduleMatchNotification(Match match) async {
    final notifyTime = match.date.subtract(const Duration(minutes: 30));

    if (notifyTime.isAfter(DateTime.now())) {
      await _plugin.zonedSchedule(
        match.id,
        '⚽ ${match.team1} vs ${match.team2}',
        'Матч начнётся в ${match.date.hour}:${match.date.minute.toString().padLeft(2, '0')} МСК',
        null,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'match_channel',
            'Матчи',
            channelDescription: 'Уведомления о начале матчей',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
          ),
        ),
      );
    }
  }

  static Future<void> showTestNotification() async {
    await _plugin.show(
      0,
      '🎯 ЧМ 2026 Аналитик готов!',
      'Выбери команду для анализа',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Тестовые',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
