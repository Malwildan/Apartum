import 'package:apartum/features/riwayat_catatan/domain/entities/sleep_daily_entity.dart';

class SleepDailyModel extends SleepDailyEntity {
  const SleepDailyModel({
    required super.date,
    required super.totalSleepMinutes,
    required super.totalSessions,
    required super.avgSleepMinutes,
    required super.sessions,
    required super.isSleeping,
  });

  factory SleepDailyModel.fromJson(Map<String, dynamic> json) {
    return SleepDailyModel(
      date: json['date'] as String? ?? '',
      totalSleepMinutes: (json['total_sleep_minutes'] as num?)?.toInt() ?? 0,
      totalSessions: (json['total_sessions'] as num?)?.toInt() ?? 0,
      avgSleepMinutes: (json['avg_sleep_minutes'] as num?)?.toInt() ?? 0,
      sessions: (json['sessions'] as List<dynamic>? ?? [])
          .map(
            (item) => SleepSessionModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      isSleeping: json['is_sleeping'] as bool? ?? false,
    );
  }
}

class SleepSessionModel extends SleepSessionEntity {
  const SleepSessionModel({
    required super.id,
    required super.start,
    required super.end,
    required super.durationMinutes,
    required super.isBackdate,
  });

  factory SleepSessionModel.fromJson(Map<String, dynamic> json) {
    final rawEnd = json['end'];

    return SleepSessionModel(
      id: json['id']?.toString() ?? '',
      start: json['start'] as String? ?? '',
      end: rawEnd is String && rawEnd.isNotEmpty && rawEnd != 'masih tidur' ? rawEnd : null,
      durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 0,
      isBackdate: json['is_backdate'] as bool? ?? false,
    );
  }
}
