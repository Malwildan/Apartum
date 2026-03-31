import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/features/homepage/domain/entities/day_sleep_entity.dart';
import 'package:apartum/features/homepage/domain/entities/day_status.dart';
import 'package:flutter/material.dart';

class DayLabelWidget extends StatelessWidget {
  const DayLabelWidget({super.key, required this.data});

  final DaySleepData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
          decoration: data.isToday
              ? BoxDecoration(
                  color: StaticColor.primaryPink,
                  borderRadius: BorderRadius.circular(11),
                )
              : null,
          child: Text(
            data.label,
            style: AppTypography.b3.copyWith(
              fontSize: 12,
              color: data.isToday
                  ? StaticColor.surface
                  : StaticColor.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 5),
        _buildStatusIcon(data.status),
      ],
    );
  }

  Widget _buildStatusIcon(DayStatus status) {
    switch (status) {
      case DayStatus.orange:
        return _letterCircle(const Color(0xFFF59F0A), 'P');
      case DayStatus.yellow:
        return _iconCircle(StaticColor.errorRed, Icons.warning_rounded);
      case DayStatus.green:
        return _iconCircle(StaticColor.successGreen, Icons.check_rounded);
      case DayStatus.dot:
        return Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: StaticColor.primaryPink.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
        );
      case DayStatus.none:
        return const SizedBox(width: 18, height: 18);
    }
  }

  Widget _iconCircle(Color color, IconData icon) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, size: 11, color: StaticColor.surface),
    );
  }

  Widget _letterCircle(Color color, String text) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        text,
        style: AppTypography.detail.copyWith(
          color: StaticColor.surface,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }
}
