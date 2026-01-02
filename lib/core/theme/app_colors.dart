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
  static const white100 = Color(0x1AFFFFFF);
  static const white300 = Color(0xFF565551);
  static const white400 = Color(0xFF73737C);
  static const white600 = Color(0x99FFFFFF);

  /// Grey
  static const shark = Color(0xFF1C1C1E);
  static const gullGrey = Color(0xFF9CA3AF);

  static const purple = Color(0xFF5B13EC);
  static const blue = Color(0xFF00D4FF);
  static const cyan = Color(0xFF00E5FF);

  /// Glow
  static const purpleGlow = Color(0xFFAB47BC);
  static const blueGlow = Color(0xFF00B0FF);
  static const cyanGlow = Color(0xFF00FFFF);


  // Backgrounds
  static const background = Color(0xFF000000);
  static const surface = Color(0xFF000000);
  static const transparent = Color(0x00000000);

  // Linear Gradient
  static const buttonGradient = [
    Color(0xFF4A90E2),
    Color(0xFFA076F9),
  ];

  // Flush Bar
  static const flushBarSuccess = Color(0xFF81C784);
  static const flushBarSuccessBackground = Color(0xFF1E1E1E);
  static const flushBarInfo =  [Color(0xFF00D4FF), Color(0xFF8B5CF6)];
  static const flushBarError =  Color(0xFFE57373);
  static const flushBarErrorBackground =  Color(0xFF1E1E1E);
  static const warning = Color(0xFF1E1E1E);
}
