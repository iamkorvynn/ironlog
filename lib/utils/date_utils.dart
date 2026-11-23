class AppDateUtils {
  static DateTime startOfDay(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day);

  static DateTime endOfDay(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day, 23, 59, 59, 999);

  static DateTime startOfWeek(DateTime dt) {
    final start = startOfDay(dt);
    return start.subtract(Duration(days: start.weekday - 1));
  }

  static DateTime endOfWeek(DateTime dt) {
    final start = startOfWeek(dt);
    return endOfDay(start.add(const Duration(days: 6)));
  }

  static List<DateTime> getPastWeeksStartDates(int count) {
    final now = DateTime.now();
    final thisMonday = startOfWeek(now);
    final List<DateTime> weeks = [];
    for (int i = count - 1; i >= 0; i--) {
      weeks.add(thisMonday.subtract(Duration(days: i * 7)));
    }
    return weeks;
  }
}
