import 'package:apartum/features/homepage/domain/entities/day_sleep_entity.dart';
import 'package:flutter/material.dart';

class SleepBarWidget extends StatelessWidget {
  const SleepBarWidget({
    super.key,
    required this.data,
    required this.plotHeight,
    required this.barWidth,
  });

  final DaySleepData data;
  final double plotHeight;
  final double barWidth;

  final double chartStartHour = 8.0;
  final double chartTotalHours = 22.0;

  double hourOffset(double hour) {
    if (hour < chartStartHour) return hour + 24 - chartStartHour;
    return hour - chartStartHour;
  }


  @override
  Widget build(BuildContext context) {
    final trackRadius = barWidth / 2;
    final availableHeight = plotHeight;

    final backgroundTrack = Container(
      width: barWidth,
      height: availableHeight,
      decoration: BoxDecoration(
        color: const Color(0xFFBBDCDF),
        borderRadius: BorderRadius.circular(trackRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );

    final startOffset = hourOffset(data.startHour);
    final endOffset = hourOffset(data.endHour);

    final topFraction = startOffset / chartTotalHours;
    final heightFraction = endOffset / chartTotalHours - topFraction;

    final topPx = topFraction * availableHeight;
    final heightPx = heightFraction.abs() * availableHeight;

    if (!data.isSleepTracked) {
      return Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            backgroundTrack,
            Positioned(
              top: topPx,
              left: 0,
              right: 0,
              child: Container(
                width: barWidth,
                height: heightPx.clamp(8.0, availableHeight),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(trackRadius),
                  border: Border.all(color: data.barColor, width: 1.4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 4,
                      offset: const Offset(0, 1.5),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.child_care_rounded,
                  size: 13,
                  color: data.barColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        backgroundTrack,
        Positioned(
          top: topPx,
          left: 0,
          right: 0,
          height: heightPx.clamp(8.0, availableHeight),
          child: Container(
            decoration: BoxDecoration(
              color: data.barColor,
              borderRadius: BorderRadius.circular(trackRadius),
              boxShadow: [
                BoxShadow(
                  color: data.barColor.withOpacity(0.35),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
