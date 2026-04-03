import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TandaBahayaEmptyState extends StatelessWidget {
  const TandaBahayaEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.medical_information_outlined,
            size: 42.sp,
            color: StaticColor.textMuted,
          ),
          SizedBox(height: 14.h),
          Text(
            'Belum ada riwayat tanda bahaya',
            textAlign: TextAlign.center,
            style: AppTypography.h2.copyWith(fontSize: 18.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            'Riwayat analisis gejala akan tampil di sini setelah Ibu mengisi catatan gejala harian.',
            textAlign: TextAlign.center,
            style: AppTypography.b2Regular.copyWith(
              height: 1.45,
              color: StaticColor.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
