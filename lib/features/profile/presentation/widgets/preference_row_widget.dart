import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:flutter/material.dart';

class PreferenceRowWidget extends StatelessWidget {
  const PreferenceRowWidget({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: StaticColor.iconMuted),
        const SizedBox(width: 14),
        Text(label, style: AppTypography.b2),
        const Spacer(),
        Icon(
          Icons.chevron_right_rounded,
          size: 18,
          color: StaticColor.textPrimary,
        ),
      ],
    );
  }
}
