import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TVSeriesPoster extends StatelessWidget {
  final String? posterPath;
  final double width;
  final double height;

  const TVSeriesPoster({
    super.key,
    this.posterPath,
    this.width = 120,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.white400.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.background.withValues(alpha: 0.7),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: posterPath != null
            ? CachedNetworkImage(
                imageUrl: context.tmdbPosterUrl(posterPath),
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.cardBackground,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.playButton,
                      strokeWidth: 3,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.cardBackground,
                  child: Icon(
                    Icons.tv,
                    color: AppColors.white400,
                    size: (width * 0.4).sp,
                  ),
                ),
              )
            : Container(
                color: AppColors.cardBackground,
                child: Icon(
                  Icons.tv,
                  color: AppColors.white400,
                  size: (width * 0.4).sp,
                ),
              ),
      ),
    );
  }
}
