import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/search_result_entity.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flicknova/core/utils/detail_navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Universal search result card that handles movie, TV, and person results
class SearchResultCard extends StatelessWidget {
  final SearchResultEntity result;

  const SearchResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DetailNavigationHelper.navigateToDetail(
          context,
          mediaType: result.mediaType,
          id: result.id,
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Poster/Profile Image
            _buildImage(context),
            SizedBox(width: 12.w),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    result.title,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  // Media type badge
                  _buildMediaTypeBadge(context),
                  if (result.overview != null &&
                      result.overview!.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Text(
                      result.overview!,
                      style: context.bodySmall.copyWith(
                        color: AppColors.white600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (result.isPerson && result.knownForDepartment != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      result.knownForDepartment!,
                      style: context.bodySmall.copyWith(
                        color: AppColors.white600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Rating (for movies/TV)
            if (!result.isPerson && result.voteAverage != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: AppColors.rating, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      result.voteAverage!.toStringAsFixed(1),
                      style: context.caption.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: result.isPerson ? 60.w : 60.w,
        height: result.isPerson ? 60.w : 90.h,
        decoration: BoxDecoration(
          color: AppColors.background,
          shape: result.isPerson ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: result.posterPath != null
            ? CachedNetworkImage(
                imageUrl: context.tmdbPosterUrl(result.posterPath),
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.background,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  result.isPerson ? Icons.person : Icons.movie,
                  color: AppColors.white400,
                  size: 24.sp,
                ),
              )
            : Icon(
                result.isPerson
                    ? Icons.person
                    : (result.isTVShow ? Icons.tv : Icons.movie),
                color: AppColors.white400,
                size: 24.sp,
              ),
      ),
    );
  }

  Widget _buildMediaTypeBadge(BuildContext context) {
    String label;
    Color color;

    switch (result.mediaType) {
      case 'movie':
        label = 'Movie';
        color = AppColors.primary;
        break;
      case 'tv':
        label = 'TV Show';
        color = const Color(0xFF10B981); // Green
        break;
      case 'person':
        label = 'Person';
        color = const Color(0xFFF59E0B); // Amber
        break;
      default:
        label = result.mediaType;
        color = AppColors.white400;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: context.caption.copyWith(
          fontSize: 10.sp,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
