// lib/core/theme/extensions/context_theme_extension.dart
import 'package:flutter/material.dart';
import '../app_text_styles.dart';

extension BuildContextX on BuildContext {
  TextStyle get h1 => AppTextStyles.h1(this);
  TextStyle get h2 => AppTextStyles.h2(this);
  TextStyle get h3 => AppTextStyles.h3(this);
  TextStyle get h4 => AppTextStyles.h4(this);
  TextStyle get bodyLarge => AppTextStyles.bodyLarge(this);
  TextStyle get body => AppTextStyles.body(this);
  TextStyle get bodyMedium => AppTextStyles.bodyMedium(this);
  TextStyle get bodySmall => AppTextStyles.bodySmall(this);
  TextStyle get caption => AppTextStyles.caption(this);
  TextStyle get button => AppTextStyles.button(this);
}