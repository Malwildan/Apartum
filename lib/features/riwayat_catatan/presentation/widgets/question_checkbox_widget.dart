import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';

class QuestionCheckboxWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> options;
  final List<String> selectedOptions;
  final ValueChanged<List<String>> onChanged;

  const QuestionCheckboxWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
    required this.selectedOptions,
    required this.onChanged,
  });

  void _toggleOption(String opt) {
    if (selectedOptions.contains(opt)) {
      onChanged(selectedOptions.where((e) => e != opt).toList());
    } else {
      onChanged([...selectedOptions, opt]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEBEBEB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.b1.copyWith(
              fontWeight: FontWeight.w700,
              color: StaticColor.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: AppTypography.b4.copyWith(color: StaticColor.primaryPink),
          ),
          SizedBox(height: 16.h),
          ...options.map((opt) {
            final isSelected = selectedOptions.contains(opt);
            return GestureDetector(
              onTap: () => _toggleOption(opt),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
                    Container(
                      width: 22.w,
                      height: 22.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: isSelected
                              ? StaticColor.primaryPink
                              : StaticColor.primaryPink.withValues(alpha: 0.6),
                          width: 1.5,
                        ),
                        color: isSelected ? StaticColor.primaryPink : Colors.transparent,
                      ),
                      alignment: Alignment.center,
                      child: isSelected
                          ? Icon(Icons.check, size: 16.w, color: Colors.white)
                          : null,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        opt,
                        style: AppTypography.b3.copyWith(
                          color: StaticColor.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
