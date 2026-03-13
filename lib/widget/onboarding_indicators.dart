import 'package:flutter/material.dart';

class OnboardingIndicators extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const OnboardingIndicators({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final bool isActive = currentIndex == index;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Image.asset(
            isActive ? 'assets/active_blood.png' : 'assets/inactive_blood.png',
            width: isActive ? 18 : 14,
            height: isActive ? 18 : 14,
          ),
        );
      }),
    );
  }
}
