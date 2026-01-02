// lib/shared/widgets/buttons/secondary_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/extensions/context_theme_extension.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? height;
  final double? width;

  const SecondaryButton({
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

  // Your exact colors from the design
  static const Color loadingColor = AppColors.secondary;   // bright teal
  static const Color _borderColor = AppColors.white300;   // bright teal
  static const Color _textColor = AppColors.textPrimary;
  static const Color _bgColor = Colors.transparent;
  static const Color _disabledColor = Color(0xFF006655);

  @override
  Widget build(BuildContext context) {
    final bool shouldEnable = isEnabled && !isLoading && onPressed != null;

    return SizedBox(
      height: height ?? 58.h,
      width: width ?? double.infinity,
      child: OutlinedButton(
        onPressed: shouldEnable ? onPressed : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: _bgColor,
          foregroundColor: _textColor,
          disabledForegroundColor: _disabledColor.withValues(alpha: 0.4),
          side: BorderSide(
            color: shouldEnable ? _borderColor : _disabledColor.withValues(alpha: 0.4),
            width: 2.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r), // perfect pill
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        ),
        child: isLoading
            ? SizedBox(
          height: 24.h,
          width: 24.w,
          child: const CircularProgressIndicator(
            color: loadingColor,
            strokeWidth: 2.5,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              SizedBox(width: 5.w),
            ],
            Text(
              text,
              style: context.bodyLarge.copyWith(
                fontSize: 17.sp,
                color: shouldEnable ? _textColor : _disabledColor.withValues(alpha: 0.6),
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