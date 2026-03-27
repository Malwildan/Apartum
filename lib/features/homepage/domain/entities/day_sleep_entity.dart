import 'package:flutter/material.dart';

import 'day_status.dart';

class DaySleepData {
  final String label;
  final double startHour;
  final double endHour;
  final bool isToday;
  final DayStatus status;
  final bool isSleepTracked;
  final Color barColor;

  const DaySleepData({
    required this.label,
    required this.startHour,
    required this.endHour,
    required this.isToday,
    required this.status,
    required this.isSleepTracked,
    required this.barColor,
  });
}
