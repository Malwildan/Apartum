import 'package:apartum/core/theme/app_theme.dart';
import 'package:apartum/features/auth/presentation/login_screen.dart';
import 'package:apartum/features/auth/presentation/register_screen.dart';
import 'package:apartum/features/homepage/presentation/homepage_screen.dart';
import 'package:apartum/features/konseling/presentation/konseling_screen.dart';
import 'package:apartum/features/konseling/presentation/konseling_detail_screen.dart';
import 'package:apartum/features/onboarding/presentation/onboarding_screen.dart';
import 'package:apartum/features/profile/presentation/edit_profile_screen.dart';
import 'package:apartum/features/profile/presentation/profile_screen.dart';
import 'package:apartum/features/riwayat_catatan/presentation/riwayat_catatan_screen.dart';
import 'package:flutter/material.dart';
import 'package:apartum/features/splash/splash_screen.dart';

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
        '/konseling': (_) => const Konselingscreen(),
        '/konseling-detail': (_) => const KonselingDetailScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/edit-profile': (_) => const EditProfileScreen(),
        '/riwayat-catatan': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          int initialTabIndex = 0;
          if (args is Map<String, dynamic>) {
            initialTabIndex = args['tabIndex'] as int? ?? 0;
          }
          return RiwayatCatatanScreen(initialTabIndex: initialTabIndex);
        },
      },
    );
  }
}
