import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';
import '../../../watchlist/domain/entities/watchlist_item_entity.dart';

class RecentRatingsSection extends StatelessWidget {
  final List<WatchlistItemEntity> recentMovies;
  final VoidCallback? onSeeAll;
  final Function(WatchlistItemEntity)? onMovieTap;

  const RecentRatingsSection({
    super.key,
    required this.recentMovies,
    this.onSeeAll,
    this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s.recent_ratings, style: context.h3),
              TextButton(
                onPressed: onSeeAll,
                child: Text(
                  s.see_all,
                  style: context.bodyMedium.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: recentMovies.take(5).length,
            itemBuilder: (context, index) {
              final movie = recentMovies[index];
              return GestureDetector(
                onTap: () => onMovieTap?.call(movie),
                child: Container(
                  width: 120.w,
                  margin: EdgeInsets.only(right: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Poster with rating
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: SizedBox(
                              width: 120.w,
                              height: 160.h,
                              child: movie.posterPath != null
                                  ? CachedNetworkImage(
                                      imageUrl: context.tmdbPosterUrl(
                                        movie.posterPath,
                                      ),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        color: AppColors.cardBackground,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            color: AppColors.cardBackground,
                                            child: Icon(
                                              Icons.movie,
                                              color: AppColors.white400,
                                            ),
                                          ),
                                    )
                                  : Container(
                                      color: AppColors.cardBackground,
                                      child: Icon(
                                        Icons.movie,
                                        color: AppColors.white400,
                                      ),
                                    ),
                            ),
                          ),
                          // Star rating badge
                          Positioned(
                            top: 8.h,
                            right: 8.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.background.withValues(
                                  alpha: 0.9,
                                ),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: const Color(0xFFFFB800),
                                    size: 12.sp,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    '8.5',
                                    style: context.caption.copyWith(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      // Title
                      Text(
                        movie.title,
                        style: context.caption.copyWith(fontSize: 12.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
