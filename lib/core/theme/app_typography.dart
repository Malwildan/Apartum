import 'package:apartum/core/theme/app_static_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {

  static TextStyle get h1 => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.bold,
    fontSize: 24.sp,
    color: StaticColor.textPrimary,
  );

  static TextStyle get h2 => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    color: StaticColor.textPrimary,
  );

  static TextStyle get h3 => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: StaticColor.textPrimary,
  );

  static TextStyle get h4 => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
    color: StaticColor.textPrimary,
  );

  static TextStyle get b1 => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: StaticColor.textPrimary,
  );

  static TextStyle get b2 => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    color: StaticColor.textPrimary,
  );

  static TextStyle get b2Regular => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: StaticColor.textPrimary,
  );

  static TextStyle get b3 => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    color: StaticColor.textPrimary,
  );

  static TextStyle get b3Regular => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: StaticColor.textPrimary,
  );

  static TextStyle get b4 => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w500,
    fontSize: 10.sp,
    color: StaticColor.textPrimary,
  );

  static TextStyle get button1 => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: StaticColor.textPrimary,
  );

  static TextStyle get button2 => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    color: StaticColor.textPrimary,
  );

  static TextStyle get button3 => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w500,
    fontSize: 10.sp,
    color: StaticColor.textPrimary,
  );

  static TextStyle get detail => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600,
    fontSize: 8.sp,
    color: StaticColor.textPrimary,
  );
}
