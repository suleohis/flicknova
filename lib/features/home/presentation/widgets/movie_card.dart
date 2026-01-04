import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/theme/app_colors.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 140.w,
        margin: EdgeInsets.only(right: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                height: height ?? 200.h,
                width: width ?? 140.w,
                color: AppColors.cardBackground,
                child: movie.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl: context.tmdbPosterUrl(movie.posterPath),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.cardBackground,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.playButton,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.cardBackground,
                          child: Icon(
                            Icons.movie,
                            color: AppColors.white400,
                            size: 48.sp,
                          ),
                        ),
                      )
                    : Icon(Icons.movie, color: AppColors.white400, size: 48.sp),
              ),
            ),
            SizedBox(height: 8.h),
            // Title
            Text(
              movie.title,
              style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            // Rating
            Row(
              children: [
                Icon(Icons.star, color: AppColors.rating, size: 14.sp),
                SizedBox(width: 4.w),
                Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: context.bodySmall.copyWith(color: AppColors.white600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
