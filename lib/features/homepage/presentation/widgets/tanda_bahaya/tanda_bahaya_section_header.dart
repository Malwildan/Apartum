import 'package:apartum/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TandaBahayaSectionHeader extends StatelessWidget {
  const TandaBahayaSectionHeader({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
      child: Text(
        label,
        style: AppTypography.h2.copyWith(fontSize: 16.sp),
      ),
    );
  }
}
