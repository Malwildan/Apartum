import 'package:auto_size_text/auto_size_text.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:flutter/material.dart';

class ProfileRowWidget extends StatelessWidget {
  const ProfileRowWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: StaticColor.iconMuted),
        const SizedBox(width: 14),
        Text(label, style: AppTypography.b2),
        const SizedBox(width: 16),
        Expanded(
          child: AutoSizeText(
            value,
            style: AppTypography.b2Regular,
            textAlign: TextAlign.right,
            maxLines: 1,
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
