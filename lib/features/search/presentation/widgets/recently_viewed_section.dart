import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';
import '../../../home/domain/entities/movie_entity.dart';

class RecentlyViewedSection extends StatelessWidget {
  final List<MovieEntity> movies;
  final VoidCallback? onClear;
  final Function(MovieEntity)? onMovieTap;

  const RecentlyViewedSection({
    super.key,
    required this.movies,
    this.onClear,
    this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    if (movies.isEmpty) {
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
              Text(s.recently_viewed, style: context.h3),
              TextButton(
                onPressed: onClear,
                child: Text(
                  s.clear,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.trendingBadge,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: movies.take(10).length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () => onMovieTap?.call(movie),
                child: Container(
                  margin: EdgeInsets.only(right: 16.w),
                  child: Column(
                    children: [
                      Container(
                        width: 80.r,
                        height: 80.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.recentlyViewedBorder,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
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
                      SizedBox(height: 8.h),
                      SizedBox(
                        width: 80.w,
                        child: Text(
                          movie.title,
                          style: context.caption,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
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
