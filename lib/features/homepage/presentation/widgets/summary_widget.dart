import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/features/homepage/domain/entities/day_sleep_entity.dart';
import 'package:apartum/features/homepage/domain/entities/day_status.dart';
import 'package:apartum/features/homepage/domain/entities/summary_status.dart';
import 'package:apartum/features/homepage/presentation/widgets/status_banner_widget.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/sleep_daily_entity.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_entity.dart';
import 'package:flutter/material.dart';

import 'day_label_widget.dart';
import 'sleep_bar_widget.dart';


class SummaryWidget extends StatelessWidget {
  const SummaryWidget({
    super.key,
    this.summaryStatus,
    this.todaySymptom,
    this.symptomHistory = const [],
    this.weeklySleep = const {},
    this.onStatusBannerTap,
  });

  final SummaryStatus? summaryStatus;
  final SymptomEntity? todaySymptom;
  final List<SymptomEntity> symptomHistory;
  final Map<String, SleepDailyEntity> weeklySleep;
  final VoidCallback? onStatusBannerTap;

  static const _barColor = Color(0xFF6DC8BF);

  static const _dayLabels = [
    'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min',
  ];

  static const _monthNames = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
  ];

  String _todayDisplay() {
    final now = DateTime.now();
    return '${now.day} ${_monthNames[now.month - 1]} ${now.year}';
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// Normalizes an API date string (plain "YYYY-MM-DD" or ISO 8601 datetime)
  /// to a local "YYYY-MM-DD" string, handling UTC-to-local conversion.
  String _normalizeApiDate(String apiDate) {
    if (apiDate.length == 10 && !apiDate.contains('T')) {
      return apiDate;
    }
    try {
      final dt = DateTime.parse(apiDate).toLocal();
      return _formatDate(dt);
    } catch (_) {
      return apiDate.length >= 10 ? apiDate.substring(0, 10) : apiDate;
    }
  }

  SymptomEntity? _findSymptomForDay({
    required String dateStr,
    required bool isToday,
  }) {
    if (isToday && todaySymptom != null) {
      return todaySymptom;
    }

    for (final symptom in symptomHistory) {
      if (todaySymptom != null && symptom.id == todaySymptom!.id) {
        continue;
      }

      if (_normalizeApiDate(symptom.date) == dateStr) {
        return symptom;
      }
    }

    return null;
  }

  double _parseTimeToHour(String timeStr) {
    String timePart = timeStr;
    if (timeStr.contains('T')) {
      timePart = timeStr.split('T')[1];
    }
    final parts = timePart.split(':');
    if (parts.length >= 2) {
      final h = int.tryParse(parts[0]) ?? 0;
      final mStr = parts[1].replaceAll(RegExp(r'[^0-9]'), '');
      final m = int.tryParse(
                mStr.length > 2 ? mStr.substring(0, 2) : mStr,
              ) ??
              0;
      return h.toDouble() + m / 60.0;
    }
    return 8.0;
  }

  List<DaySleepData> _buildWeekData() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));

    return List.generate(7, (i) {
      final day = monday.add(Duration(days: i));
      final dateStr = _formatDate(day);
      final isToday = _isSameDay(day, now);

      final sleep = weeklySleep[dateStr];
      final symptom = _findSymptomForDay(dateStr: dateStr, isToday: isToday);

      DayStatus dayStatus;
      if (symptom != null) {
        switch (symptom.alert?.level) {
          case 'safe':
            dayStatus = DayStatus.green;
            break;
          case 'warning':
            dayStatus = DayStatus.orange;
            break;
          case 'danger':
            dayStatus = DayStatus.yellow;
            break;
          default:
            dayStatus = DayStatus.dot;
        }
      } else {
        dayStatus = DayStatus.none;
      }

      if (sleep == null || sleep.sessions.isEmpty) {
        return DaySleepData(
          label: _dayLabels[i],
          startHour: 8.0,
          endHour: 8.0,
          isToday: isToday,
          status: dayStatus,
          isSleepTracked: false,
          barColor: Colors.transparent,
        );
      }

      double earliestStart = double.infinity;
      double latestEnd = double.negativeInfinity;

      for (final session in sleep.sessions) {
        final start = _parseTimeToHour(session.start);
        if (start < earliestStart) earliestStart = start;
        if (session.end != null) {
          final end = _parseTimeToHour(session.end!);
          if (end > latestEnd) latestEnd = end;
        }
      }

      if (earliestStart == double.infinity) earliestStart = 8.0;
      if (latestEnd == double.negativeInfinity) latestEnd = earliestStart;

      return DaySleepData(
        label: _dayLabels[i],
        startHour: earliestStart,
        endHour: latestEnd,
        isToday: isToday,
        status: dayStatus,
        isSleepTracked: true,
        barColor: _barColor,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final weekData = _buildWeekData();
    const chartHeight = 207.0;
    const plotHeight = chartHeight - 62.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCFCFD2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 10),
          StatusBannerWidget(
            status: summaryStatus ?? SummaryStatus.none,
            onTap: onStatusBannerTap ?? () {},
          ),
          const SizedBox(height: 12),
          _buildChart(weekData, chartHeight: chartHeight, plotHeight: plotHeight),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ringkasan', style: AppTypography.h2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hari ini',
              style: AppTypography.b2Regular.copyWith(
                color: StaticColor.textPrimary,
              ),
            ),
            const SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
              decoration: BoxDecoration(
                color: StaticColor.primaryPink,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _todayDisplay(),
                style: AppTypography.b4.copyWith(
                  color: StaticColor.surface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
      ],
    );
  }

  Widget _buildChart(
    List<DaySleepData> weekData, {
    required double chartHeight,
    required double plotHeight,
  }) {
    final timeLabels = [
      '08.00', '10.00', '12.00', '14.00', '16.00', '18.00',
      '20.00', '22.00', '00.00', '02.00', '04.00', '06.00',
    ];

    return SizedBox(
      height: chartHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            padding: const EdgeInsets.only(top: 2),
            child: SizedBox(
              height: plotHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: timeLabels
                    .map(
                      (label) => Text(
                        label,
                        style: AppTypography.b4.copyWith(
                          color: StaticColor.textMuted,
                          height: 1,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final chartWidth = constraints.maxWidth;
                final barWidth = chartWidth / 7;
                const barWidthFactor = 0.70;

                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: plotHeight,
                      child: Row(
                        children: List.generate(7, (i) {
                          return SizedBox(
                            width: barWidth,
                            child: Center(
                              child: SleepBarWidget(
                                data: weekData[i],
                                plotHeight: plotHeight,
                                barWidth: barWidth * barWidthFactor,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        children: List.generate(7, (i) {
                          return SizedBox(
                            width: barWidth,
                            child: DayLabelWidget(data: weekData[i]),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
