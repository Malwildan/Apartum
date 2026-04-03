import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'sleep_helpers.dart';

class SleepTimeFieldWidget extends StatelessWidget {
  final TimeOfDay? time;
  final VoidCallback onTap;

  const SleepTimeFieldWidget({
    super.key,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: StaticColor.primaryPink, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.access_time, color: StaticColor.primaryPink, size: 18.w),
            SizedBox(width: 6.w),
            Text(
              time != null
                  ? SleepHelpers.formatTime(time!.hour, time!.minute)
                  : '--:--',
              style: AppTypography.b3.copyWith(
                color: time != null ? StaticColor.textPrimary : StaticColor.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SleepTimeChipWidget extends StatelessWidget {
  final TimeOfDay time;

  const SleepTimeChipWidget({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: StaticColor.primaryPink, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.access_time, color: StaticColor.primaryPink, size: 18.w),
          SizedBox(width: 6.w),
          Text(
            SleepHelpers.formatTime(time.hour, time.minute),
            style: AppTypography.b3.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
