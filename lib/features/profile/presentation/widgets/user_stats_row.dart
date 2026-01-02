import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';

class UserStatsRow extends StatelessWidget {
  final int moviesWatched;
  final int totalHours;
  final double avgRating;

  const UserStatsRow({
    super.key,
    required this.moviesWatched,
    required this.totalHours,
    required this.avgRating,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(value: moviesWatched.toString(), label: 'Movies Watched'),
          _StatItem(value: '${totalHours}h', label: 'Total'),
          _StatItem(
            value: avgRating.toStringAsFixed(1),
            label: 'Avg Rating',
            showStar: true,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool showStar;

  const _StatItem({
    required this.value,
    required this.label,
    this.showStar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: context.h2.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (showStar) ...[
              SizedBox(width: 4.w),
              Icon(Icons.star, color: const Color(0xFFFFB800), size: 20.sp),
            ],
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: context.caption.copyWith(
            color: AppColors.white600,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
