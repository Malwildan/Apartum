import 'package:apartum/core/theme/app_static_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ApartumTheme {

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: StaticColor.primaryPink,
      brightness: Brightness.light,
      primary: StaticColor.primaryPink,
      onPrimary: Colors.white,
      secondary: StaticColor.successGreen,
      onSecondary: Colors.white,
      error: StaticColor.errorRed,
      onError: Colors.white,
      surface: StaticColor.surface,
      onSurface: StaticColor.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: StaticColor.background,

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: StaticColor.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: StaticColor.textPrimary,
        ),
        iconTheme: const IconThemeData(color: StaticColor.textPrimary),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: StaticColor.primaryPink,
          foregroundColor: Colors.white,
          disabledBackgroundColor: StaticColor.disabled,
          disabledForegroundColor: StaticColor.disabledText,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: StaticColor.primaryPink,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          side: const BorderSide(color: StaticColor.primaryPink, width: 1.5),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF1F3F6),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: StaticColor.primaryPink,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: StaticColor.errorRed, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: StaticColor.errorRed, width: 1.5),
        ),
        hintStyle: GoogleFonts.plusJakartaSans(
          color: StaticColor.textMuted,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: GoogleFonts.plusJakartaSans(
          color: StaticColor.textMuted,
          fontSize: 14.sp,
        ),
      ),

      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6.h),
      ),




      textSelectionTheme: TextSelectionThemeData(
        cursorColor: StaticColor.primaryPink,
        selectionColor: StaticColor.primaryPink.withOpacity(0.25),
        selectionHandleColor: StaticColor.primaryPinkDark,
      ),


      datePickerTheme: DatePickerThemeData(
        backgroundColor: StaticColor.surface,
        surfaceTintColor: StaticColor.surface,
        dividerColor: const Color(0xFFEDEFF2),
        headerBackgroundColor: StaticColor.primaryPink,
        headerForegroundColor: Colors.white,
        weekdayStyle: GoogleFonts.plusJakartaSans(
          color: StaticColor.textMuted,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        dayStyle: GoogleFonts.plusJakartaSans(
          color: StaticColor.textPrimary,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.white;
          if (states.contains(WidgetState.disabled)) {
            return const Color(0xFFB0B8C2);
          }
          return StaticColor.textPrimary;
        }),
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return StaticColor.primaryPink;
          }
          return null;
        }),
        todayForegroundColor: const WidgetStatePropertyAll(
          StaticColor.primaryPinkDark,
        ),
        todayBorder: const BorderSide(color: StaticColor.primaryPinkDark),
        yearForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.white;
          return StaticColor.textPrimary;
        }),
        yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return StaticColor.primaryPink;
          }
          return null;
        }),
        cancelButtonStyle: TextButton.styleFrom(
          foregroundColor: StaticColor.primaryPinkDark,
        ),
        confirmButtonStyle: TextButton.styleFrom(
          foregroundColor: StaticColor.primaryPink,
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        actionTextColor: StaticColor.warningYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFF1F3F6),
        selectedColor: StaticColor.primaryPink.withOpacity(0.12),
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: StaticColor.textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        side: BorderSide.none,
      ),

      dividerTheme: const DividerThemeData(
        color: Color(0xFFEDEFF2),
        thickness: 1,
        space: 1,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: StaticColor.textPrimary,
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
      ),

      // ── ProgressIndicator ──
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: StaticColor.primaryPink,
        linearTrackColor: Color(0xFFEDEFF2),
      ),

      // ── Checkbox / Radio ──
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return StaticColor.primaryPink;
          }
          return Colors.transparent;
        }),
        checkColor: const WidgetStatePropertyAll(Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return StaticColor.primaryPink;
          }
          return StaticColor.textMuted;
        }),
      ),
    );
  }
}
