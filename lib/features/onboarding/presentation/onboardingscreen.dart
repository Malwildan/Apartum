import 'package:apartum/core/global_widget/button.dart';
import 'package:apartum/features/onboarding/presentation/widgets/pagination_widget.dart';
import 'package:apartum/features/onboarding/data/onboarding_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: const Color(0xFFF4F4F5),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 36),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Image.asset(
                    item.image,
                    key: ValueKey<String>(item.image),
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 36),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    item.title,
                    key: ValueKey<String>(item.title),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFFFF4D6D),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    item.description,
                    key: ValueKey<String>(item.description),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFF202123),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ),
                const Spacer(),
                Opacity(
                  opacity: _currentIndex == onboardingData.length - 1 ? 1 : 0,
                  child: AppButton(
                    label: 'Mulai Sekarang',
                    textStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                  ),
                ),
                SizedBox(height: 64),
                Padding(
                  padding: const EdgeInsets.only(bottom: 28),
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
