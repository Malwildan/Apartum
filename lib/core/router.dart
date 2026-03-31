import 'package:apartum/core/theme/app_theme.dart';
import 'package:apartum/features/auth/presentation/loginscreen.dart';
import 'package:apartum/features/auth/presentation/registerscreen.dart';
import 'package:apartum/features/homepage/presentation/homepagescreen.dart';
import 'package:apartum/features/konseling/presentation/konselingscreen.dart';
import 'package:apartum/features/onboarding/presentation/onboardingscreen.dart';
import 'package:apartum/features/profile/presentation/editprofilescreen.dart';
import 'package:apartum/features/profile/presentation/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:apartum/features/splash/splashscreen.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apartum',
      debugShowCheckedModeBanner: false,
      theme: ApartumTheme.light,
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const HomePageScreen(),
        // '/pencatatan': (_) => const HalamanPencatatan(),
        '/konseling': (_) => const Konselingscreen(),
        '/profile': (_) => const ProfileScreen(),
        '/edit-profile': (_) => const EditProfileScreen(),
      },
    );
  }
}
