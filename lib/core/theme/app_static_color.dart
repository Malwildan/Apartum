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
}
