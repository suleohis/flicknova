import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/tv_show_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';
import '../../../../routes/app_router.dart';
import '../providers/trending_notifier.dart';

class TrendingTVWidget extends ConsumerWidget {
  const TrendingTVWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final trendingState = ref.watch(trendingProvider);

    if (trendingState.trendingTV.isEmpty && !trendingState.isLoading) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Trending TV Shows', style: context.h3),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to see all trending TV
                },
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
          height: 240.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: trendingState.trendingTV.length,
            itemBuilder: (context, index) {
              final tvShow = trendingState.trendingTV[index];
              return _TrendingTVCard(tvShow: tvShow);
            },
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}

class _TrendingTVCard extends StatelessWidget {
  final TVShowEntity tvShow;

  const _TrendingTVCard({required this.tvShow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRouter.tvDetail, extra: tvShow.id);
      },
      child: Container(
        width: 120.w,
        margin: EdgeInsets.only(right: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: SizedBox(
                    width: 120.w,
                    height: 180.h,
                    child: tvShow.posterPath != null
                        ? CachedNetworkImage(
                            imageUrl: context.tmdbPosterUrl(tvShow.posterPath),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColors.cardBackground,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.cardBackground,
                              child: Icon(
                                Icons.tv,
                                color: AppColors.white400,
                                size: 32.sp,
                              ),
                            ),
                          )
                        : Container(
                            color: AppColors.cardBackground,
                            child: Icon(
                              Icons.tv,
                              color: AppColors.white400,
                              size: 32.sp,
                            ),
                          ),
                  ),
                ),
                // Rating badge
                if (tvShow.voteAverage > 0)
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background.withValues(alpha: 0.9),
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
                            tvShow.voteAverage.toStringAsFixed(1),
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
              tvShow.name,
              style: context.bodyMedium.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
