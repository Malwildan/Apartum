class SleepDailyEntity {
  final String date;
  final int totalSleepMinutes;
  final int totalSessions;
  final int avgSleepMinutes;
  final List<SleepSessionEntity> sessions;
  final bool isSleeping;

  const SleepDailyEntity({
    required this.date,
    required this.totalSleepMinutes,
    required this.totalSessions,
    required this.avgSleepMinutes,
    required this.sessions,
    required this.isSleeping,
  });
}

class SleepSessionEntity {
  final String id;
  final String start;
  final String? end;
  final int durationMinutes;
  final bool isBackdate;

  const SleepSessionEntity({
    required this.id,
    required this.start,
    required this.end,
    required this.durationMinutes,
    required this.isBackdate,
  });
}
