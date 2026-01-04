import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/tv_show_entity.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TVCard extends StatelessWidget {
  final TVShowEntity tvShow;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const TVCard({
    super.key,
    required this.tvShow,
    this.width = 120,
    this.height = 180,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                width: width.w,
                height: height.h,
                color: AppColors.cardBackground,
                child: tvShow.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl: context.tmdbPosterUrl(tvShow.posterPath),
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: AppColors.cardBackground),
                        errorWidget: (context, url, error) => Icon(
                          Icons.tv,
                          color: AppColors.white400,
                          size: 40.sp,
                        ),
                      )
                    : Icon(Icons.tv, color: AppColors.white400, size: 40.sp),
              ),
            ),
            SizedBox(height: 8.h),
            // Title
            Text(
              tvShow.name,
              style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
