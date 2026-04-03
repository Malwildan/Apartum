import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F9),
        borderRadius: BorderRadius.circular(12),
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
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.b4.copyWith(color: StaticColor.primaryPink),
          ),
          const SizedBox(height: 16),
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
                    const SizedBox(height: 8),
                    Container(
                      width: 22,
                      height: 22,
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
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: StaticColor.primaryPink,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(height: 4),
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
