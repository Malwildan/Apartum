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

final List<DaySleepData> weekDataSample = [
  const DaySleepDataModel(
    label: 'Sen',
    startHour: 20.0,
    endHour: 3.5,
    isToday: false,
    status: DayStatus.orange,
    isSleepTracked: true,
    barColor: Color(0xFF6DC8BF),
  ),
  const DaySleepDataModel(
    label: 'Sel',
    startHour: 14.5,
    endHour: 22.5,
    isToday: false,
    status: DayStatus.yellow,
    isSleepTracked: true,
    barColor: Color(0xFFE05C6E),
  ),
  const DaySleepDataModel(
    label: 'Rab',
    startHour: 19.5,
    endHour: 3.0,
    isToday: false,
    status: DayStatus.orange,
    isSleepTracked: true,
    barColor: Color(0xFF6DC8BF),
  ),
  const DaySleepDataModel(
    label: 'Kam',
    startHour: 16.5,
    endHour: 1.5,
    isToday: true,
    status: DayStatus.green,
    isSleepTracked: true,
    barColor: Color(0xFFF4A7B3),
  ),
  const DaySleepDataModel(
    label: 'Jum',
    startHour: 0,
    endHour: 0,
    isToday: false,
    status: DayStatus.dot,
    isSleepTracked: false,
    barColor: Color(0xFFFF6A87),
  ),
  const DaySleepDataModel(
    label: 'Sab',
    startHour: 0,
    endHour: 0,
    isToday: false,
    status: DayStatus.dot,
    isSleepTracked: false,
    barColor: Color(0xFF6DC8BF),
  ),
  const DaySleepDataModel(
    label: 'Min',
    startHour: 0,
    endHour: 0,
    isToday: false,
    status: DayStatus.dot,
    isSleepTracked: false,
    barColor: Color(0xFF6DC8BF),
  ),
];
