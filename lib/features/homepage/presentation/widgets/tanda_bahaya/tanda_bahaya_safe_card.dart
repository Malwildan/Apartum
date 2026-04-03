import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/features/homepage/presentation/widgets/tanda_bahaya/tanda_bahaya_date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TandaBahayaSafeCard extends StatelessWidget {
  const TandaBahayaSafeCard({super.key, required this.dateStr});

  final String dateStr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEAFBF4),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFB7EDD8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: const BoxDecoration(
                  color: Color(0xFFD1F7E8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: StaticColor.successGreen,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Semuanya aman!',
                      style: AppTypography.b1.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Tidak ada gejala yang mengindikasikan kondisi yang serius.',
                      style: AppTypography.b3.copyWith(
                        color: StaticColor.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              formatTandaBahayaDate(dateStr),
              style: AppTypography.b4.copyWith(color: StaticColor.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}
