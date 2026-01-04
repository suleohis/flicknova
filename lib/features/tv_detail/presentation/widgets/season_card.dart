import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/common_detail_entities.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/tv_series_detail_entity.dart';

class SeasonCard extends StatelessWidget {
  final SeasonSummaryEntity season;
  final VoidCallback? onTap;

  const SeasonCard({super.key, required this.season, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Season thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                width: 60.w,
                height: 60.w,
                color: AppColors.background,
                child: season.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl: context.tmdbPosterUrl(season.posterPath),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(
                          Icons.tv,
                          color: AppColors.white400,
                          size: 24.sp,
                        ),
                      )
                    : Icon(Icons.tv, color: AppColors.white400, size: 24.sp),
              ),
            ),
            SizedBox(width: 12.w),
            // Season info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    season.name,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${season.episodeCount} Episodes',
                    style: context.bodySmall.copyWith(
                      color: AppColors.white600,
                    ),
                  ),
                ],
              ),
            ),
            // Rating
            if (season.voteAverage > 0) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: AppColors.linkColor, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      season.voteAverage.toStringAsFixed(1),
                      style: context.caption.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(width: 8.w),
            // Chevron
            Icon(Icons.chevron_right, color: AppColors.white400, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
