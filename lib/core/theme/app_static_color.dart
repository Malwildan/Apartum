import 'package:flutter/material.dart';

class StaticColor {
  static const Color primaryPink = Color(0xFFFF4D6D);
  static const Color primaryPinkDark = Color(0xFFCC3E57);
  static const Color successGreen = Color(0xFF3ECF8E);
  static const Color warningYellow = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color surface = Colors.white;
  static const Color background = Color(0xFFF7F8FA);
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textMuted = Color(0xFF6B7280);

  // ── Gradients ──
  static const LinearGradient linearPink = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      // Color(0xFFFF4D6D),
      //Color(0xFFFFA6B6),
      Color(0xFFFFD2DA),
      Color(0xFFFFFFFF),
    ],
  );

  // ── Additional semantic colors ──
  static const Color iconMuted = Color(0xFF4B4B4B);
  static const Color divider = Color(0xFFD3D5DC);
  static const Color disabled = Color(0xFFD0D0D0);
  static const Color disabledText = Color(0xFF8A8A8A);
  static const Color destructive = Color(0xFFFF3B30);

  // ── Info Banner ──
  static const Color bannerDefaultBackground = Color(0xFFFDEEEF);
  static const Color bannerDefaultBorder = Color(0xFFF5A3A9);
  static const Color bannerDefaultIcon = Color(0xFF421518);
  static const Color bannerDefaultText = Color(0xFF5B112B);

  static const Color bannerDangerBackground = Color(0xFFFFE8E8);
  static const Color bannerDangerBorder = Color(0xFFE05252);
  static const Color bannerDangerIcon = Color(0xFF8B1A1A);
  static const Color bannerDangerText = Color(0xFF7B0000);

  static const Color bannerWarningBackground = Color(0xFFFFF8E1);
  static const Color bannerWarningBorder = Color(0xFFFFB74D);
  static const Color bannerWarningIcon = Color(0xFF8A5200);
  static const Color bannerWarningText = Color(0xFF5D3A00);

  static const Color bannerDoneBackground = Color(0xFFE4F6F1);
  static const Color bannerDoneBorder = Color(0xFF5AB6A5);
  static const Color bannerDoneIcon = Color(0xFF5AB6A5);
  static const Color bannerDoneText = Color(0xFF1B6254);

  // ── Sleep Entry ──
  static const Color sleepNoticeBackground = Color(0xFFF5F5F5);
  static const Color sleepingStatusBackground = Color(0xFFFFF0F0);
  static const Color completedStatusBackground = Color(0xFFE8F8EF);
  static const Color completedStatusText = Color(0xFF1B6E3D);
  static const Color pinkLight = Color(0xFFFF8FA3);
}
