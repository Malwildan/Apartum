import 'package:apartum/features/auth/presentation/pages/loginscreen.dart';
import 'package:apartum/features/auth/presentation/pages/registerscreen.dart';
import 'package:apartum/features/homepage/presentation/homepagescreen.dart';
import 'package:apartum/features/konseling/presentation/konselingscreen.dart';
import 'package:apartum/features/onboarding/presentation/onboardingscreen.dart';
import 'package:apartum/features/profile/presentation/editprofilescreen.dart';
import 'package:apartum/features/profile/presentation/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:apartum/features/splash/splashscreen.dart';

class _ApartumTheme {
  static const Color primaryPink = Color(0xFFFF4D6D);
  static const Color primaryPinkDark = Color(0xFFCC3E57);
  static const Color successGreen = Color(0xFF3ECF8E);
  static const Color warningYellow = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color surface = Colors.white;
  static const Color background = Color(0xFFF7F8FA);
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textMuted = Color(0xFF6B7280);

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryPink,
        onPrimary: Colors.white,
        secondary: successGreen,
        onSecondary: textPrimary,
        error: errorRed,
        onError: Colors.white,
        surface: surface,
        onSurface: textPrimary,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textPrimary),
        bodyMedium: TextStyle(color: textMuted),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryPink,
        selectionColor: primaryPink.withOpacity(0.25),
        selectionHandleColor: primaryPinkDark,
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: surface,
        surfaceTintColor: surface,
        dividerColor: const Color(0xFFEDEFF2),
        headerBackgroundColor: primaryPink,
        headerForegroundColor: Colors.white,
        weekdayStyle: const TextStyle(
          color: textMuted,
          fontWeight: FontWeight.w600,
        ),
        dayStyle: const TextStyle(
          color: textPrimary,
          fontWeight: FontWeight.w500,
        ),
        dayForegroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          if (states.contains(MaterialState.disabled)) {
            return const Color(0xFFB0B8C2);
          }
          return textPrimary;
        }),
        dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryPink;
          }
          return null;
        }),
        todayForegroundColor: const MaterialStatePropertyAll(primaryPinkDark),
        todayBorder: const BorderSide(color: primaryPinkDark),
        yearForegroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return textPrimary;
        }),
        yearBackgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryPink;
          }
          return null;
        }),
        cancelButtonStyle: TextButton.styleFrom(foregroundColor: primaryPinkDark),
        confirmButtonStyle: TextButton.styleFrom(foregroundColor: primaryPink),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        actionTextColor: warningYellow,
      ),
    );
  }
}

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apartum',
      debugShowCheckedModeBanner: false,
      theme: _ApartumTheme.light,
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