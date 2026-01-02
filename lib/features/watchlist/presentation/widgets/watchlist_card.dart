import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';
import '../../domain/entities/watchlist_item_entity.dart';

class WatchlistCard extends StatelessWidget {
  final WatchlistItemEntity item;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const WatchlistCard({
    super.key,
    required this.item,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onRemove,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.cardBackground,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Poster Image
              if (item.posterPath != null)
                CachedNetworkImage(
                  imageUrl: context.tmdbPosterUrl(item.posterPath),
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: AppColors.cardBackground),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.cardBackground,
                    child: Icon(
                      Icons.movie,
                      color: AppColors.white400,
                      size: 48.sp,
                    ),
                  ),
                )
              else
                Container(
                  color: AppColors.cardBackground,
                  child: Icon(
                    Icons.movie,
                    color: AppColors.white400,
                    size: 48.sp,
                  ),
                ),

              // Gradient overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.background,
                        AppColors.background.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Runtime badge (top right)
              if (item.episodeProgress != null)
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      item.episodeProgress!,
                      style: context.caption.copyWith(
                        color: AppColors.background,
                        fontWeight: FontWeight.w700,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),

              // Title and progress (bottom)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.title,
                        style: context.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (item.totalEpisodes != null &&
                          item.episodesWatched != null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          s.episodes_watched(
                            item.episodesWatched!,
                            item.totalEpisodes!,
                          ),
                          style: context.caption.copyWith(
                            color: AppColors.white600,
                            fontSize: 10.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
