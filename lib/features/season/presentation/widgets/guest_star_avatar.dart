import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/models/season_entity.dart';
import '../../../../core/network/tmdb_service.dart';
import '../../../../core/theme/app_colors.dart';

class GuestStarAvatar extends StatelessWidget {
  final GuestStarEntity guestStar;

  const GuestStarAvatar({super.key, required this.guestStar});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.cardBackground,
          ),
          clipBehavior: Clip.antiAlias,
          child: guestStar.profilePath != null
              ? CachedNetworkImage(
                  imageUrl:
                      '${TmdbService.baseImageUrl}${TmdbService.profileSize}${guestStar.profilePath}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.trendingBadge,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.person,
                    size: 32.sp,
                    color: AppColors.white600,
                  ),
                )
              : Icon(Icons.person, size: 32.sp, color: AppColors.white600),
        ),
        SizedBox(height: 6.h),
        SizedBox(
          width: 70.w,
          child: Text(
            guestStar.name,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
