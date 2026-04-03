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

  bool get _isLastPage => _currentIndex == onboardingData.length - 1;

  @override
  Widget build(BuildContext context) {
    final item = onboardingData[_currentIndex];

    return Scaffold(
      backgroundColor: StaticColor.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isCompactHeight = constraints.maxHeight < 720;
            final double imageHeight =
                constraints.maxHeight * (isCompactHeight ? 0.32 : 0.38);
            final double maxContentWidth = 340.w;

            return Padding(
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 20.h),
              child: Column(
                children: [
                  SizedBox(height: isCompactHeight ? 8.h : 20.h),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: SizedBox(
                      key: ValueKey<String>(item.image),
                      height: imageHeight,
                      child: Image.asset(item.image, fit: BoxFit.contain),
                    ),
                  ),
                  SizedBox(height: isCompactHeight ? 28.h : 44.h),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: AutoSizeText(
                        item.title,
                        key: ValueKey<String>(item.title),
                        minFontSize: 24,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: AppTypography.h1.copyWith(
                          color: StaticColor.primaryPink,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxContentWidth),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: AutoSizeText(
                            item.description,
                            key: ValueKey<String>(item.description),
                            minFontSize: 14,
                            maxLines: 4,
                            textAlign: TextAlign.center,
                            style: AppTypography.b1.copyWith(
                              color: StaticColor.textPrimary,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: SizedBox(
                      height: _isLastPage ? 52.h : 0,
                      child: _isLastPage
                          ? AppButton(
                              label: 'Mulai Sekarang',
                              height: 52.h,
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushReplacementNamed('/login');
                              },
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  SizedBox(height: _isLastPage ? 22.h : 28.h),
                  PaginationWidget(
                    pageCount: onboardingData.length,
                    initialPage: _currentIndex,
                    onPageChanged: (page) {
                      setState(() => _currentIndex = page);
                    },
                  ),
                  SizedBox(height: 54.h)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
