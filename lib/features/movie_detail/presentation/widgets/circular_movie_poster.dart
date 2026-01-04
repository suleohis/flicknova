import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularMoviePoster extends StatelessWidget {
  final String? posterPath;
  final double size;

  const CircularMoviePoster({super.key, this.posterPath, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.white400.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.background.withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipOval(
        child: posterPath != null
            ? CachedNetworkImage(
                imageUrl: context.tmdbPosterUrl(posterPath),
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
                    Icons.movie_outlined,
                    color: AppColors.white400,
                    size: (size * 0.4).sp,
                  ),
                ),
              )
            : Container(
                color: AppColors.cardBackground,
                child: Icon(
                  Icons.movie_outlined,
                  color: AppColors.white400,
                  size: (size * 0.4).sp,
                ),
              ),
      ),
    );
  }
}
