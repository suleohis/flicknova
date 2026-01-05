import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/theme/app_colors.dart';

class TrendingSearchItem extends StatelessWidget {
  final MovieEntity movie;
  final int rank;
  final VoidCallback? onTap;

  const TrendingSearchItem({
    super.key,
    required this.movie,
    required this.rank,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final showTrendingBadge = rank <= 2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          children: [
            // Rank badge
            Container(
              width: 40.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.rankBadge,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Center(
                child: Text(
                  '#$rank',
                  style: context.h4.copyWith(
                    color: AppColors.background,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SizedBox(
                width: 80.w,
                height: 120.h,
                child: movie.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl: context.tmdbPosterUrl(movie.posterPath),
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: AppColors.cardBackground),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.cardBackground,
                          child: Icon(Icons.movie, color: AppColors.white400),
                        ),
                      )
                    : Container(
                        color: AppColors.cardBackground,
                        child: Icon(Icons.movie, color: AppColors.white400),
                      ),
              ),
            ),
            SizedBox(width: 12.w),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: context.h4,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        size: 16.sp,
                        color: AppColors.trendingBadge,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${(movie.voteAverage * 10).toStringAsFixed(0)}%',
                        style: context.bodySmall.copyWith(
                          color: AppColors.white600,
                        ),
                      ),
                      if (showTrendingBadge) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.trendingBadge,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Trending',
                            style: context.caption.copyWith(
                              color: AppColors.background,
                              fontWeight: FontWeight.w700,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    movie.releaseDate?.split('-').first ?? 'N/A',
                    style: context.caption.copyWith(color: AppColors.white600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
