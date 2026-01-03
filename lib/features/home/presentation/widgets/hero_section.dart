import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';
import '../../domain/entities/movie_entity.dart';

class HeroSection extends StatelessWidget {
  final MovieEntity movie;
  final VoidCallback? onPlayTrailerTap;
  final VoidCallback? onAddTap;
  final VoidCallback? onTap;

  const HeroSection({
    super.key,
    required this.movie,
    this.onPlayTrailerTap,
    this.onAddTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 500.h,
        width: double.infinity,
        child: Stack(
          children: [
            // Backdrop image
            if (movie.backdropPath != null)
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: context.tmdbBackdropUrl(movie.backdropPath),
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: AppColors.cardBackground),
                  errorWidget: (context, url, error) =>
                      Container(color: AppColors.cardBackground),
                ),
              ),
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.transparent,
                      AppColors.background.withValues(alpha: 0.7),
                      AppColors.background,
                    ],
                    stops: const [0.0, 0.7, 1.0],
                  ),
                ),
              ),
            ),
            // Content
            Positioned(
              bottom: 30.h,
              left: 16.w,
              right: 16.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    movie.title,
                    style: context.h1.copyWith(
                      fontSize: 32.sp,
                      shadows: [
                        Shadow(
                          color: AppColors.background.withValues(alpha: 0.8),
                          offset: Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.h),
                  // Rating and release date
                  Row(
                    children: [
                      Icon(Icons.star, color: AppColors.rating, size: 20.sp),
                      SizedBox(width: 4.w),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: context.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (movie.releaseDate != null) ...[
                        SizedBox(width: 12.w),
                        Container(
                          width: 4.w,
                          height: 4.w,
                          decoration: BoxDecoration(
                            color: AppColors.white600,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          movie.releaseDate!.split('-').first,
                          style: context.bodyMedium.copyWith(
                            color: AppColors.white600,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onPlayTrailerTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.playButton,
                            foregroundColor: AppColors.background,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            elevation: 0,
                          ),
                          icon: Icon(Icons.play_arrow, size: 24.sp),
                          label: Text(
                            s.play_trailer,
                            style: context.button.copyWith(
                              color: AppColors.background,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: IconButton(
                          onPressed: onAddTap,
                          icon: Icon(
                            Icons.add,
                            color: AppColors.white,
                            size: 24.sp,
                          ),
                          padding: EdgeInsets.all(14.sp),
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
