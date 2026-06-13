import 'package:device_calendar/device_calendar.dart';
import '../models/models.dart';

class CalendarService {
  static final DeviceCalendarPlugin _calendar = DeviceCalendarPlugin();

  static Future<void> init() async {
    await _requestCalendarPermission();
  }

  static Future<bool> _requestCalendarPermission() async {
    try {
      final result = await _calendar.requestCalendarPermissions();
      return result != null && result;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addMatchToCalendar(Match match) async {
    try {
      final calendars = await _calendar.retrieveCalendars();
      if (calendars == null || calendars.isEmpty) return false;

      final calendar = calendars.first;
      final event = Event(
        calendar.id,
        title: '${match.flag1} ${match.team1} vs ${match.team2} ${match.flag2}',
        description: 'Матч группового этапа ЧМ 2026',
        start: match.date,
        end: match.date.add(const Duration(hours: 3)),
      );

      final result = await _calendar.createOrUpdateEvent(event);
      return result != null && result;
    } catch (e) {
      return false;
    }
  }
}
