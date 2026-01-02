// lib/shared/widgets/buttons/primary_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flicknova/core/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? height;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final bool shouldEnable = isEnabled && !isLoading && onPressed != null;

    return Container(
      height: height ?? 56.h,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: shouldEnable
              ? AppColors.buttonGradient
              : AppColors.isDisabledButtonGradient,
        ),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: ElevatedButton(
        onPressed: shouldEnable ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          disabledBackgroundColor: AppColors.secondary.withValues(alpha: 0.4),
          foregroundColor: AppColors.white,
          elevation: 0,
          shadowColor: AppColors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r), // Perfect pill shape
          ),
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? SizedBox(
                height: 24.h,
                width: 24.w,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    SizedBox(width: 12.w),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: AppColors.white,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    SizedBox(width: 12.w),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
