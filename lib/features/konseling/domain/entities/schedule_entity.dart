class ScheduleEntity {
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final String label;

  const ScheduleEntity({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.label,
  });
}
