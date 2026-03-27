import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoScaleController;
  late AnimationController _slideController;
  late AnimationController _textFadeController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoSlideAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _textRevealAnimation;
  late Animation<double> _textSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Controller for logo pop-up (scale in)
    _logoScaleController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    // Controller for logo sliding left + text appearing
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Controller for text fade in
    _textFadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Logo pops in with a spring-like scale
    _logoScaleAnimation = CurvedAnimation(
      parent: _logoScaleController,
      curve: Curves.elasticOut,
    );

    // Logo slides to the left
    _logoSlideAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );

    // Text fades in from slightly right
    _textFadeAnimation = CurvedAnimation(
      parent: _textFadeController,
      curve: Curves.easeIn,
    );

    // Reveals text width from 0 so logo starts truly centered.
    _textRevealAnimation = CurvedAnimation(
      parent: _textFadeController,
      curve: Curves.easeInOutCubic,
    );

    _textSlideAnimation = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(parent: _textFadeController, curve: Curves.easeOut),
    );

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    // Step 1: Logo pops in
    await Future.delayed(const Duration(milliseconds: 300));
    await _logoScaleController.forward();

    // Step 2: After logo appears, slide left and show text
    await Future.delayed(const Duration(milliseconds: 250));
    _slideController.forward();

    await Future.delayed(const Duration(milliseconds: 100));
    await _textFadeController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacementNamed('/onboarding');
  }

  @override
  void dispose() {
    _logoScaleController.dispose();
    _slideController.dispose();
    _textFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _logoScaleController,
            _slideController,
            _textFadeController,
          ]),
          builder: (context, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo with slide + scale animation
                Transform.translate(
                  offset: Offset(_logoSlideAnimation.value, 0),
                  child: ScaleTransition(
                    scale: _logoScaleAnimation,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),

                // Reveal text width while keeping it vertically centered to logo.
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: _textRevealAnimation.value,
                    child: SizedBox(
                      height: 80,
                      child: Center(
                        child: FadeTransition(
                          opacity: _textFadeAnimation,
                          child: Transform.translate(
                            offset: Offset(_textSlideAnimation.value, 0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Apartum',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFFF2D78),
                                  //letterSpacing: -0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}