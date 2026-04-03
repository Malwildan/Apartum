import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

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
            final isSelected = selectedOptions.contains(opt);
            return GestureDetector(
              onTap: () => _toggleOption(opt),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
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
                          ? const Icon(Icons.check, size: 16, color: Colors.white)
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
