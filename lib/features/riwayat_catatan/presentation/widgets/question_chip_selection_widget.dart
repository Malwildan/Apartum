import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';

class QuestionChipSelectionWidget extends StatelessWidget {
  final String title;
  final List<String> options; // Text with emojis like "😄 Bahagia"
  final List<String> selectedOptions;
  final ValueChanged<String> onToggle;
  final Color backgroundColor;
  final Color primaryColor;

  const QuestionChipSelectionWidget({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOptions,
    required this.onToggle,
    required this.backgroundColor,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.h4.copyWith(
              fontWeight: FontWeight.w700,
              color: StaticColor.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: options.map((opt) {
              final isSelected = selectedOptions.contains(opt);
              return GestureDetector(
                onTap: () => onToggle(opt),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : primaryColor,
                    ),
                  ),
                  child: Text(
                    opt,
                    style: AppTypography.b2.copyWith(
                      color: isSelected ? Colors.white : primaryColor,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
