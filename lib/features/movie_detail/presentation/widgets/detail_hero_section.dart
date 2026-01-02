import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/movie_detail_entity.dart';

class DetailHeroSection extends StatelessWidget {
  final MovieDetailEntity movie;

  const DetailHeroSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.h,
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
                    AppColors.background.withValues(alpha: 0.3),
                    AppColors.background.withValues(alpha: 0.9),
                    AppColors.background,
                  ],
                  stops: const [0.0, 0.5, 0.8, 1.0],
                ),
              ),
            ),
          ),
          // Title at bottom
          Positioned(
            bottom: 30.h,
            left: 16.w,
            right: 16.w,
            child: Text(
              movie.title,
              style: context.h1.copyWith(
                fontSize: 36.sp,
                shadows: [
                  Shadow(
                    color: AppColors.background.withValues(alpha: 0.8),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
