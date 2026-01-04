import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final String? suggestion;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorStateWidget({
    super.key,
    required this.message,
    this.suggestion,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64.sp, color: AppColors.white400),
            SizedBox(height: 16.h),
            Text(
              message,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (suggestion != null) ...[
              SizedBox(height: 8.h),
              Text(
                suggestion!,
                style: TextStyle(color: AppColors.white600, fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.playButton,
                  foregroundColor: AppColors.background,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                icon: Icon(Icons.refresh, size: 20.sp),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
