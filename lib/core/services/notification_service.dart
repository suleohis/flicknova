import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NotificationService {
  static void showSuccess({
    required BuildContext context,
    required String message,
    required String title,
  }) {
    Flushbar(
      title: title,
      message: message,
      icon: Icon(Icons.check_circle, color: AppColors.flushBarSuccess),
      backgroundColor: AppColors.flushBarSuccess.withValues(alpha: 0.9),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
      borderRadius: BorderRadius.circular(12),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      duration: const Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.TOP,
      animationDuration: const Duration(milliseconds: 600),
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
    ).show(context);
  }

  static void showError({
    required BuildContext context,
    required String message,
    String title = 'Error',
  }) {
    Flushbar(
      title: title,
      message: message,
      icon: Icon(Icons.error, color: AppColors.flushBarError),
      backgroundColor: AppColors.flushBarErrorBackground.withValues(alpha: 0.9),
      // Add glassmorphic blur if you wrap in BackdropFilter (advanced)
      boxShadows: [/* same as above */],
      // ... same styling
      duration: const Duration(seconds: 5),
    ).show(context);
  }

  static void showInfo({
    required BuildContext context,
    required String message,
  }) {
    Flushbar(
      message: message,
      backgroundGradient: const LinearGradient(colors: AppColors.flushBarInfo),
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}
