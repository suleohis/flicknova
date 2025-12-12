// lib/core/theme/app_text_styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

@immutable
class AppTextStyles {
  const AppTextStyles._();

  static double _scale(BuildContext context, {required double mobile, double? tablet, double? desktop}) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1200) return desktop ?? tablet ?? mobile;
    if (width >= 600) return tablet ?? mobile;
    return mobile;
  }

  // HEADINGS
  static TextStyle h1(BuildContext context) => GoogleFonts.spaceGrotesk(
    fontWeight: FontWeight.w700,
    fontSize: _scale(context, mobile: 28, tablet: 32, desktop: 36),
    height: 1.2,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  static TextStyle h2(BuildContext context) => GoogleFonts.splineSans(
    fontWeight: FontWeight.w700,
    fontSize: _scale(context, mobile: 24, tablet: 28, desktop: 32),
    height: 1.25,
    color: AppColors.textPrimary,
  );

  static TextStyle h3(BuildContext context) => GoogleFonts.splineSans(
    fontWeight: FontWeight.w700,
    fontSize: _scale(context, mobile: 22, tablet: 24, desktop: 26),
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static TextStyle h4(BuildContext context) => GoogleFonts.splineSans(
    fontWeight: FontWeight.w600,
    fontSize: _scale(context, mobile: 18, tablet: 20, desktop: 22),
    height: 1.4,
    color: AppColors.textPrimary,
  );

  // BODY
  static TextStyle bodyLarge(BuildContext context) =>  GoogleFonts.splineSans(
    fontWeight: FontWeight.w500,
    fontSize: _scale(context, mobile: 16, tablet: 17, desktop: 18),
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static TextStyle body(BuildContext context) =>  GoogleFonts.splineSans(
    fontWeight: FontWeight.w400,
    fontSize: _scale(context, mobile: 14, tablet: 16, desktop: 17),
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium(BuildContext context) =>  GoogleFonts.splineSans(
    fontWeight: FontWeight.w500,
    fontSize: _scale(context, mobile: 14, tablet: 16, desktop: 17),
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySmall(BuildContext context) =>  GoogleFonts.splineSans(
    fontWeight: FontWeight.w400,
    fontSize: _scale(context, mobile: 13, tablet: 14, desktop: 15),
    height: 1.45,
    color: AppColors.textSecondary,
  );

  static TextStyle caption(BuildContext context) =>  GoogleFonts.splineSans(
    fontWeight: FontWeight.w500,
    fontSize: _scale(context, mobile: 12, tablet: 13, desktop: 14),
    height: 1.4,
    color: AppColors.textSecondary,
  );

  static TextStyle button(BuildContext context) =>  GoogleFonts.splineSans(
    fontWeight: FontWeight.w600,
    fontSize: _scale(context, mobile: 15, tablet: 16, desktop: 17),
    height: 1.5,
    letterSpacing: 0.2,
    color: AppColors.onPrimary,
  );
}