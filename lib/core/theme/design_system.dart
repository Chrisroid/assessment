import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppColors {
  final Color primary;
  final Color textPrimary;
  final Color textSecondary;
  final Color background;
  final Color surface;
  final Color activeIndicator;
  final Color inactiveIndicator;
  final Color badgeBackground;

  const AppColors({
    required this.primary,
    required this.textPrimary,
    required this.textSecondary,
    required this.background,
    required this.surface,
    required this.activeIndicator,
    required this.inactiveIndicator,
    required this.badgeBackground,
  });

  static const light = AppColors(
    primary: Color(0xfff5811f),
    textPrimary: Color(0xFF1B1C1E),
    textSecondary: Color(0xFFB3B3B4),
    background: Colors.white,
    surface: Color(0xFFF9F9F9), // grey[50]
    activeIndicator: Colors.deepOrange,
    inactiveIndicator: Color(0xFFE0E0E0), // grey[300]
    badgeBackground: Color(0x0CF5811F), // Color(0xfff5811f).withAlpha(12)
  );
}

class AppTypography {
  final TextStyle heading;   // 16px Medium
  final TextStyle title;     // 14px Medium
  final TextStyle subtitle;  // 14px Regular
  final TextStyle body;      // 12px Regular
  final TextStyle caption;   // 12px Grey Regular

  const AppTypography({
    required this.heading,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.caption,
  });

  static const defaultTypography = AppTypography(
    heading: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Color(0xFF1B1C1E),
    ),
    title: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Color(0xFF1B1C1E),
    ),
    subtitle: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Color(0xFFB3B3B4),
    ),
    body: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Color(0xFF1B1C1E),
    ),
    caption: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Color(0xFFB3B3B4),
    ),
  );
}

class DesignSystem {
  final AppColors colors;
  final AppTypography typography;

  const DesignSystem({required this.colors, required this.typography});
}

final designSystemProvider = Provider<DesignSystem>((ref) {
  return const DesignSystem(
    colors: AppColors.light,
    typography: AppTypography.defaultTypography,
  );
});
