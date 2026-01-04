import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flicknova/features/person_detail/domain/entities/filmography_item.dart';
import 'package:flicknova/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FilmographyItemWidget extends StatelessWidget {
  final FilmographyItem item;

  const FilmographyItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate based on media type
        if (item.mediaType == 'tv') {
          context.push(AppRouter.tvDetail, extra: item.id);
        } else {
          context.push(AppRouter.movieDetail, extra: item.id);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.divider.withValues(alpha: 0.3),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // Year
            SizedBox(
              width: 50.w,
              child: Text(
                item.year?.toString() ?? '-',
                style: context.bodyMedium.copyWith(
                  color: AppColors.white600,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            // Title and character
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.character.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      'as ${item.character}',
                      style: context.bodySmall.copyWith(
                        color: AppColors.linkColor,
                        fontSize: 12.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            // Chevron
            Icon(Icons.chevron_right, color: AppColors.white400, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
