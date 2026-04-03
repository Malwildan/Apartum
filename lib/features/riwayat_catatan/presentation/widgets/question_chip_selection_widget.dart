import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
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
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((opt) {
              final isSelected = selectedOptions.contains(opt);
              return GestureDetector(
                onTap: () => onToggle(opt),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
