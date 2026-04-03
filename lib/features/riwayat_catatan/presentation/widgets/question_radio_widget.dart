import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class QuestionRadioWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String?> onChanged;

  const QuestionRadioWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  });

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
          ...options.map((opt) {
            final isSelected = selectedOption == opt;
            return GestureDetector(
              onTap: () => onChanged(opt),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
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
                    const SizedBox(width: 12),
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
