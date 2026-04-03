import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';

class RiwayatCalendarWidget extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime focusedDay;
  final void Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final ValueChanged<DateTime> onPageChanged;

  const RiwayatCalendarWidget({
    super.key,
    required this.selectedDate,
    required this.focusedDay,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  static const _weekdayShortNames = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
  static const _monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  /// Returns the Monday of the week containing [date].
  DateTime _weekStart(DateTime date) {
    // weekday: Mon=1 … Sun=7
    return date.subtract(Duration(days: date.weekday - 1));
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final lastDay = DateTime(today.year, today.month, today.day);

    final weekStart = _weekStart(focusedDay);
    final weekDays = List.generate(7, (i) => weekStart.add(Duration(days: i)));

    // Determine display month from the majority of days in the week
    final title = '${_monthNames[focusedDay.month - 1]} ${focusedDay.year}';

    // Can go to next week only if weekStart + 7 does not exceed today
    final nextWeekStart = weekStart.add(const Duration(days: 7));
    final canGoNext = !nextWeekStart.isAfter(lastDay);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: StaticColor.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: StaticColor.divider.withValues(alpha: 0.5)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header: chevron left | month year | chevron right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: () {
                  final prevWeek = weekStart.subtract(const Duration(days: 7));
                  onPageChanged(prevWeek);
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.chevron_left, color: StaticColor.textPrimary),
                ),
              ),
              Text(
                title,
                style: AppTypography.b2.copyWith(fontWeight: FontWeight.w700),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: canGoNext
                    ? () => onPageChanged(nextWeekStart)
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.chevron_right,
                    color: canGoNext ? StaticColor.textPrimary : StaticColor.textMuted,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Weekday name labels row
          Row(
            children: weekDays.map((day) {
              final label = _weekdayShortNames[day.weekday % 7];
              return Expanded(
                child: Center(
                  child: Text(
                    label,
                    style: AppTypography.b3.copyWith(
                      color: StaticColor.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 8.h),
          // Day cells row
          Row(
            children: weekDays.map((day) {
              final isToday = _isSameDay(day, lastDay);
              final isSelected = _isSameDay(day, selectedDate);
              final isFuture = day.isAfter(lastDay);

              BoxDecoration? decoration;
              if (isSelected) {
                decoration = BoxDecoration(
                  color: StaticColor.primaryPink,
                  borderRadius: BorderRadius.circular(15.r),
                );
              } else if (isToday) {
                decoration = BoxDecoration(
                  color: StaticColor.primaryPink.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(15.r),
                );
              }

              TextStyle textStyle;
              if (isSelected) {
                textStyle = AppTypography.b3.copyWith(
                  color: StaticColor.surface,
                  fontWeight: FontWeight.w700,
                );
              } else if (isToday) {
                textStyle = AppTypography.b3.copyWith(
                  color: StaticColor.primaryPink,
                  fontWeight: FontWeight.w700,
                );
              } else if (isFuture) {
                textStyle = AppTypography.b3.copyWith(
                  color: StaticColor.textMuted,
                  fontWeight: FontWeight.w500,
                );
              } else {
                textStyle = AppTypography.b3.copyWith(
                  color: StaticColor.textPrimary,
                  fontWeight: FontWeight.w500,
                );
              }

              return Expanded(
                child: GestureDetector(
                  onTap: isFuture
                      ? null
                      : () => onDaySelected(day, day),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.w),
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    decoration: decoration,
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: textStyle,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
