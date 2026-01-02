import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/cast_entity.dart';

class CastCard extends StatelessWidget {
  final CastEntity cast;

  const CastCard({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.only(right: 12.w),
      child: Column(
        children: [
          // Profile image
          Container(
            width: 80.r,
            height: 80.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.castCardBackground,
            ),
            child: ClipOval(
              child: cast.profilePath != null
                  ? CachedNetworkImage(
                      imageUrl: context.tmdbProfileUrl(cast.profilePath),
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: AppColors.castCardBackground),
                      errorWidget: (context, url, error) => Icon(
                        Icons.person,
                        color: AppColors.white400,
                        size: 40.sp,
                      ),
                    )
                  : Icon(Icons.person, color: AppColors.white400, size: 40.sp),
            ),
          ),
          SizedBox(height: 8.h),
          // Name
          Text(
            cast.name,
            style: context.bodySmall.copyWith(fontWeight: FontWeight.w600),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          // Character
          Text(
            cast.character,
            style: context.caption.copyWith(color: AppColors.white600),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
