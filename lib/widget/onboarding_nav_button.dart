import 'package:apartum/widget/app_button.dart';
import 'package:flutter/material.dart';

class OnboardingNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const OnboardingNavButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap == null ? 0 : 1,
      child: IgnorePointer(
        ignoring: onTap == null,
        child: AppButton(
          width: 58,
          height: 58,
          borderRadius: 24,
          icon: icon,
          onPressed: onTap,
        ),
      ),
    );
  }
}
