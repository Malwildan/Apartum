class SleepHelpers {
  SleepHelpers._();

  static String formatTime(int hour, int minute) =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  static String formatDuration(int startHour, int startMinute, int endHour, int endMinute) {
    final startMinutes = startHour * 60 + startMinute;
    var endMinutes = endHour * 60 + endMinute;
    if (endMinutes < startMinutes) endMinutes += 24 * 60;
    final total = endMinutes - startMinutes;
    if (total <= 0) return '0 menit';
    final h = total ~/ 60;
    final m = total % 60;
    if (h == 0) return '$m menit';
    if (m == 0) return '$h jam';
    return '$h jam $m menit';
  }

  static String formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static String toRfc3339(DateTime dateTime) {
    final year = dateTime.year.toString().padLeft(4, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');
    final offset = dateTime.timeZoneOffset;
    final sign = offset.isNegative ? '-' : '+';
    final absoluteOffset = offset.abs();
    final offsetHour = absoluteOffset.inHours.toString().padLeft(2, '0');
    final offsetMinute =
        (absoluteOffset.inMinutes % 60).toString().padLeft(2, '0');
    return '$year-$month-${day}T$hour:$minute:$second$sign$offsetHour:$offsetMinute';
  }

  static (String, String) buildManualSleepPayload(
    int startHour,
    int startMinute,
    int endHour,
    int endMinute,
  ) {
    final now = DateTime.now();
    final startDateTime =
        DateTime(now.year, now.month, now.day, startHour, startMinute);
    var endDateTime =
        DateTime(now.year, now.month, now.day, endHour, endMinute);
    if (endDateTime.isBefore(startDateTime)) {
      endDateTime = endDateTime.add(const Duration(days: 1));
    }
    return (toRfc3339(startDateTime), toRfc3339(endDateTime));
  }

  static ({int hour, int minute}) parseTimeOfDay(String value) {
    try {
      if (value.isEmpty) return (hour: 0, minute: 0);
      final colonParts = value.split(':');
      if (colonParts.length == 2) {
        final hour = int.tryParse(colonParts[0]);
        final minute = int.tryParse(colonParts[1]);
        if (hour != null && minute != null) return (hour: hour, minute: minute);
      }
      final normalized = value.replaceFirstMapped(
        RegExp(r'(\.\d{6})\d+'),
        (m) => m.group(1)!,
      );
      final dateTime = DateTime.parse(normalized).toLocal();
      return (hour: dateTime.hour, minute: dateTime.minute);
    } catch (_) {
      return (hour: 0, minute: 0);
    }
  }
}
