import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';

class RiwayatTabsWidget extends StatelessWidget {
  final int activeIndex; // 0 = Riwayat Gejala, 1 = Riwayat Tidur Bayi
  final ValueChanged<int> onTap;

  const RiwayatTabsWidget({
    super.key,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onTap(0),
            child: Column(
              children: [
                Text(
                  'Riwayat Gejala',
                  style: AppTypography.b1.copyWith(
                    fontWeight: FontWeight.w700,
                    color: activeIndex == 0
                        ? StaticColor.primaryPink
                        : StaticColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 3.h,
                  color: activeIndex == 0
                      ? StaticColor.primaryPink
                      : Colors.transparent,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onTap(1),
            child: Column(
              children: [
                Text(
                  'Riwayat Tidur Bayi',
                  style: AppTypography.b1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: activeIndex == 1
                        ? StaticColor.primaryPink
                        : StaticColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 3.h,
                  color: activeIndex == 1
                      ? StaticColor.primaryPink
                      : Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
