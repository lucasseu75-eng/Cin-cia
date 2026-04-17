import 'package:flutter/material.dart';

class AppColors {
  // Common Colors
  static const Color primary = Color(0xFFD84444);
  static const Color success = Color(0xFF22C55E);
  static const Color white = Colors.white;

  // Dark Mode Colors
  static const Color backgroundDark = Color(0xFF0D1015);
  static const Color surfaceDark = Color(0xFF1A1D23);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static Color borderDark = Colors.white.withOpacity(0.05);

  // Light Mode Colors
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF111827);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static Color borderLight = Colors.black.withOpacity(0.05);
  
  // Shadows
  static List<BoxShadow> shadowLight = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 15,
      offset: const Offset(0, 4),
    ),
  ];

  // Legacy (maintaining compatibility until fully migrated)
  static const Color background = backgroundDark;
  static const Color surface = surfaceDark;
  static const Color textBody = textSecondaryDark;
}
