import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/features/onboarding/presentation/widgets/pagination_widget.dart';
import 'package:apartum/features/onboarding/data/onboarding_data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final item = onboardingData[_currentIndex];

    return Scaffold(
      backgroundColor: StaticColor.background,
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 24.h),
                Expanded(
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Image.asset(
                        item.image,
                        key: ValueKey<String>(item.image),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 48.h),
                SizedBox(
                  height: 156.h,
                  child: Column(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Text(
                          item.title,
                          key: ValueKey<String>(item.title),
                          textAlign: TextAlign.center,
                          style: AppTypography.h1.copyWith(
                            color: StaticColor.primaryPink,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: AutoSizeText(
                          item.description,
                          //minFontSize: 10,
                          maxLines: 4,
                          key: ValueKey<String>(item.description),
                          textAlign: TextAlign.center,
                          style: AppTypography.b1.copyWith(
                            color: StaticColor.textPrimary,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Opacity(
                  opacity: _currentIndex == onboardingData.length - 1 ? 1 : 0,
                  child: AppButton(
                    label: 'Mulai Sekarang',
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                  ),
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: PaginationWidget(
                    pageCount: onboardingData.length,
                    initialPage: _currentIndex,
                    onPageChanged: (page) {
                      setState(() => _currentIndex = page);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
