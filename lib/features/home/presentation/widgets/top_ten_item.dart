import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/theme/app_colors.dart';

class TopTenItem extends StatelessWidget {
  final int rank;
  final MovieEntity movie;
  final VoidCallback? onTap;

  const TopTenItem({
    super.key,
    required this.rank,
    required this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120.h,
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          children: [
            // Rank number
            Container(
              width: 60.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.numberGradient,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Center(
                child: Text(
                  '$rank',
                  style: context.h1.copyWith(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w900,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = AppColors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                width: 80.w,
                height: 120.h,
                color: AppColors.cardBackground,
                child: movie.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl: context.tmdbPosterUrl(movie.posterPath),
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: AppColors.cardBackground),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.movie, color: AppColors.white400),
                      )
                    : Icon(Icons.movie, color: AppColors.white400),
              ),
            ),
            SizedBox(width: 12.w),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.title,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.star, color: AppColors.rating, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: context.bodyMedium.copyWith(
                          color: AppColors.white600,
                        ),
                      ),
                    ],
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
