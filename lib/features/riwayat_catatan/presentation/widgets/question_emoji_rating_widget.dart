import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';

class QuestionEmojiRatingWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final int? selectedValue;
  final ValueChanged<int?> onChanged;

  const QuestionEmojiRatingWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selectedValue,
    required this.onChanged,
  });

  static const List<String> _emojis = [
    '\u{1F642}', // Slightly smiling
    '\u{1F610}', // Neutral
    '\u{1F623}', // Persevering
    '\u{1F62B}', // Tired
    '\u{1F629}', // Weary
  ];

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              final val = index + 1;
              final isSelected = selectedValue == val;
              return GestureDetector(
                onTap: () => onChanged(val),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  children: [
                    Text(
                      _emojis[index],
                      style: const TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: 22.w,
                      height: 22.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? StaticColor.primaryPink
                              : StaticColor.primaryPink.withValues(alpha: 0.6),
                          width: 1.5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: isSelected
                          ? Container(
                              width: 12.w,
                              height: 12.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: StaticColor.primaryPink,
                              ),
                            )
                          : null,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      val.toString(),
                      style: AppTypography.b3.copyWith(
                        color: StaticColor.textPrimary,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
