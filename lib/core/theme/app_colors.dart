// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

@immutable
class AppColors {
  const AppColors._();

  static const primary = Color(0xFFE50914);
  static const onPrimary = Color(0xFFFFFFFF);
  static const secondary = Color(0xFF2559F4);
  static const onSecondary = Color(0xFFFFFFFF);

  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF565551);
  static const textTertiary = Color(0xFF1D2939);

  static const success = Color(0xFF039855);
  static const successContainer = Color(0xFFA6F4C5);
  static const error = Color(0xFFB00020);
  static const errorContainer = Color(0xFFFFDAD6);

  /// White
  static const white = Color(0xFFFFFFFF);
  static const white300 = Color(0xFF565551);
  static const white400 = Color(0xFF73737C);

  /// Grey
  static const gullGrey = Color(0xFF9CA3AF);



  // Backgrounds
  static const background = Color(0xFF000000);
  static const surface = Color(0xFF000000);
  static const transparent = Color(0x00000000);

  // Linear Gradient
  static const buttonGradient = [
    Color(0xFF4A90E2),
    Color(0xFFA076F9),
  ];
}
