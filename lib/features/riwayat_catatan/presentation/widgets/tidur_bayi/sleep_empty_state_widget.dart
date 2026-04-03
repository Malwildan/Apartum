import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';

class SleepEmptyStateWidget extends StatelessWidget {
  final DateTime selectedDate;
  final bool isToday;
  final VoidCallback onAddNew;

  const SleepEmptyStateWidget({
    super.key,
    required this.selectedDate,
    required this.isToday,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        '${selectedDate.day.toString().padLeft(2, '0')}-'
        '${selectedDate.month.toString().padLeft(2, '0')}-'
        '${selectedDate.year}';

    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: StaticColor.surface,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: StaticColor.divider.withOpacity(0.5)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.nightlight_round,
              size: 40.w,
              color: const Color(0xFF9CA3AF),
            ),
            SizedBox(height: 16.h),
            Text(
              isToday
                  ? 'Belum ada catatan tidur hari ini.'
                  : 'Data riwayat tidur tidak ditemukan',
              textAlign: TextAlign.center,
              style: AppTypography.h3.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            Text(
              isToday
                  ? 'Belum ada riwayat tidur yang tersimpan untuk hari ini.'
                  : 'Belum ada riwayat tidur yang tersimpan untuk tanggal $formattedDate.',
              textAlign: TextAlign.center,
              style: AppTypography.b3.copyWith(
                color: StaticColor.textMuted,
                height: 1.4,
              ),
            ),
            if (isToday) ...[
              SizedBox(height: 20.h),
              AppButton(
                label: 'Tambahkan catatan',
                onPressed: onAddNew,
                height: 25.h,
                width: 190.w,
                borderRadius: 24.r,
                backgroundColor: StaticColor.primaryPink,
                foregroundColor: StaticColor.surface,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                leading: Icon(
                  Icons.add_circle_outline,
                  color: StaticColor.surface,
                  size: 16.w,
                ),
                textStyle:
                    AppTypography.button2.copyWith(color: StaticColor.surface),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
