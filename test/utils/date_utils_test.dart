import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/utils/date_utils.dart';

void main() {
  group('AppDateUtils', () {
    test('startOfDay zeros out time components', () {
      final dt = DateTime(2026, 11, 23, 15, 45, 12, 345);
      final sod = AppDateUtils.startOfDay(dt);
      expect(sod.year, 2026);
      expect(sod.month, 11);
      expect(sod.day, 23);
      expect(sod.hour, 0);
      expect(sod.minute, 0);
      expect(sod.second, 0);
      expect(sod.millisecond, 0);
    });

    test('endOfDay sets 23:59:59.999', () {
      final dt = DateTime(2026, 11, 23, 10, 0);
      final eod = AppDateUtils.endOfDay(dt);
      expect(eod.hour, 23);
      expect(eod.minute, 59);
      expect(eod.second, 59);
      expect(eod.millisecond, 999);
    });

    test('startOfWeek returns Monday of the week', () {
      // 2026-11-23 is Monday
      final monday = DateTime(2026, 11, 23);
      expect(AppDateUtils.startOfWeek(monday).weekday, DateTime.monday);

      // 2026-11-25 is Wednesday
      final wednesday = DateTime(2026, 11, 25);
      final start = AppDateUtils.startOfWeek(wednesday);
      expect(start.weekday, DateTime.monday);
      expect(start.day, 23);
    });

    test('endOfWeek returns Sunday of the week', () {
      final dt = DateTime(2026, 11, 23);
      final eow = AppDateUtils.endOfWeek(dt);
      expect(eow.weekday, DateTime.sunday);
      expect(eow.day, 29);
    });

    test('getPastWeeksStartDates returns correct length and order', () {
      final weeks = AppDateUtils.getPastWeeksStartDates(8);
      expect(weeks.length, 8);
      for (int i = 0; i < weeks.length - 1; i++) {
        expect(weeks[i].isBefore(weeks[i + 1]), isTrue);
      }
    });
  });
}


  group('AppDateUtils - additional time tests', () {
    test('startOfDay retains original date parts', () {
      final dt = DateTime.utc(2026, 11, 23, 23, 59, 59);
      final sod = AppDateUtils.startOfDay(dt);
      expect(sod.day, 23);
      expect(sod.hour, 0);
    });
  });
