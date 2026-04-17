import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.inter(
          color: AppColors.textPrimaryDark,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.0,
        ),
        displayMedium: GoogleFonts.inter(
          color: AppColors.textPrimaryDark,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        titleLarge: GoogleFonts.inter(
          color: AppColors.textPrimaryDark,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.inter(
          color: AppColors.textPrimaryDark,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.inter(
          color: AppColors.textPrimaryDark,
        ),
        bodyMedium: GoogleFonts.inter(
          color: AppColors.textSecondaryDark,
        ),
        labelLarge: GoogleFonts.inter(
          color: AppColors.textPrimaryDark,
          fontWeight: FontWeight.w800,
          letterSpacing: 2.0,
        ),
      ),
      inputDecorationTheme: _inputTheme(AppColors.surfaceDark, AppColors.textSecondaryDark),
      elevatedButtonTheme: _elevatedButtonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(),
      chipTheme: _chipTheme(AppColors.surfaceDark, AppColors.textPrimaryDark),
    );
  }

  static ThemeData get lightTheme {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textPrimaryLight,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimaryLight),
        titleTextStyle: TextStyle(color: AppColors.textPrimaryLight, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.inter(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.0,
        ),
        displayMedium: GoogleFonts.inter(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        titleLarge: GoogleFonts.inter(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.inter(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.inter(
          color: AppColors.textPrimaryLight,
        ),
        bodyMedium: GoogleFonts.inter(
          color: AppColors.textSecondaryLight,
        ),
        labelLarge: GoogleFonts.inter(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.w800,
          letterSpacing: 2.0,
        ),
      ),
      inputDecorationTheme: _inputTheme(AppColors.white, AppColors.textSecondaryLight),
      elevatedButtonTheme: _elevatedButtonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(),
      chipTheme: _chipTheme(AppColors.white, AppColors.textPrimaryLight),
    );
  }

  static InputDecorationTheme _inputTheme(Color fillColor, Color hintColor) => InputDecorationTheme(
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        hintStyle: TextStyle(color: hintColor),
        labelStyle: TextStyle(
          color: hintColor,
          fontWeight: FontWeight.w800,
          letterSpacing: 2.0,
        ),
      );

  static ElevatedButtonThemeData _elevatedButtonTheme() => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            fontSize: 16,
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.all(Colors.white10),
        ),
      );

  static OutlinedButtonThemeData _outlinedButtonTheme() => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            fontSize: 16,
          ),
        ),
      );

  static ChipThemeData _chipTheme(Color bgColor, Color labelColor) => ChipThemeData(
        backgroundColor: bgColor,
        selectedColor: AppColors.primary,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        labelStyle: GoogleFonts.inter(
          color: labelColor,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        showCheckmark: false,
      );
}
