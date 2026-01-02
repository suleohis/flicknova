import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';

class YearReviewCard extends StatelessWidget {
  final VoidCallback? onTap;

  const YearReviewCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final currentYear = DateTime.now().year;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(20.w),
        height: 120.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF1E3A8A), // Dark blue
              Color(0xFF3B82F6), // Blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              s.year_in_review(currentYear),
              style: context.h3.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              s.cinematic_journey,
              style: context.bodyMedium.copyWith(
                color: AppColors.white.withValues(alpha: 0.8),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
