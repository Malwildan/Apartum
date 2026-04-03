import 'package:flutter/material.dart';

import '../../domain/entities/day_sleep_entity.dart';
import '../../domain/entities/day_status.dart';

class DaySleepDataModel extends DaySleepData {
  const DaySleepDataModel({
    required super.label,
    required super.startHour,
    required super.endHour,
    required super.isToday,
    required super.status,
    required super.isSleepTracked,
    required super.barColor,
  });

  factory DaySleepDataModel.fromJson(Map<String, dynamic> json) {
    return DaySleepDataModel(
      label: json['label'] as String? ?? '',
      startHour: (json['startHour'] as num?)?.toDouble() ?? 0,
      endHour: (json['endHour'] as num?)?.toDouble() ?? 0,
      isToday: json['isToday'] as bool? ?? false,
      status: DayStatus.values.firstWhere(
        (value) => value.name == (json['status'] as String? ?? ''),
        orElse: () => DayStatus.none,
      ),
      isSleepTracked: json['isSleepTracked'] as bool? ?? false,
      barColor: Color(json['barColor'] as int? ?? 0xFF6DC8BF),
    );
  }
}