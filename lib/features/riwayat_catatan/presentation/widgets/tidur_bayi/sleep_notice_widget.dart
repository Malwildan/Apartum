import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';

class SleepNoticeWidget extends StatelessWidget {
  final String text;

  const SleepNoticeWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: StaticColor.sleepNoticeBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: StaticColor.textMuted, width: 1.5),
            ),
            alignment: Alignment.center,
            child: Text(
              '!',
              style: AppTypography.detail.copyWith(
                color: StaticColor.textMuted,
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: AppTypography.b3.copyWith(color: StaticColor.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}
