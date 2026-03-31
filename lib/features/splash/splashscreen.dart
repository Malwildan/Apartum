import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:apartum/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    _logoScaleController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _textFadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _logoScaleAnimation = CurvedAnimation(
      parent: _logoScaleController,
      curve: Curves.elasticOut,
    );

    _logoSlideAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );

    _textFadeAnimation = CurvedAnimation(
      parent: _textFadeController,
      curve: Curves.easeIn,
    );

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
    await Future.delayed(const Duration(milliseconds: 300));
    await _logoScaleController.forward();

    await Future.delayed(const Duration(milliseconds: 250));
    _slideController.forward();

    await Future.delayed(const Duration(milliseconds: 100));
    await _textFadeController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) {
      return;
    }

    var authState = context.read<AuthCubit>().state;

    // If the storage check is taking longer than the animation, wait for it
    if (authState is AuthInitial) {
      authState = await context.read<AuthCubit>().stream.firstWhere(
        (state) => state is! AuthInitial && state is! AuthLoading,
      );
    }

    if (!mounted) return;

    if (authState is AuthSuccess) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/onboarding');
    }
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
      backgroundColor: StaticColor.surface,
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
                                style: AppTypography.h1.copyWith(
                                  fontSize: 32,
                                  color: StaticColor.primaryPink,
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
