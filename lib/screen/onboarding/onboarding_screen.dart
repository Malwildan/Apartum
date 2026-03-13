import 'package:apartum/data/onboarding_data.dart';
import 'package:apartum/screen/auth/login.dart';
import 'package:apartum/widget/app_button.dart';
import 'package:apartum/widget/onboarding_indicators.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  void _goToPreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentIndex == OnboardingText.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 62),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: OnboardingText.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = OnboardingText[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexend(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFA4C75),
                            height: 1.18,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF1E1E1E),
                            height: 1.45,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              if (isLastPage) ...[
                OnboardingIndicators(itemCount: OnboardingText.length, currentIndex: _currentIndex),
                const SizedBox(height: 34),
                AppButton(
                  width: double.infinity,
                  label: 'Mulai Sekarang',
                  onPressed: _goToLogin,
                  textStyle: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.1,
                  ),
                ),
              ] else
                Row(
                  children: [
                    Opacity(
                      opacity: _currentIndex == 0 ? 0 : 1,
                      child: IgnorePointer(
                        ignoring: _currentIndex == 0,
                        child: AppButton(
                          width: 58,
                          height: 58,
                          borderRadius: 24,
                          icon: Icons.arrow_back_rounded,
                          onPressed: _goToPreviousPage,
                        ),
                      ),
                    ),
                    Expanded(
                      child: OnboardingIndicators(
                        itemCount: OnboardingText.length,
                        currentIndex: _currentIndex,
                      ),
                    ),
                    AppButton(
                      width: 58,
                      height: 58,
                      borderRadius: 24,
                      icon: Icons.arrow_forward_rounded,
                      onPressed: _goToNextPage,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

}
