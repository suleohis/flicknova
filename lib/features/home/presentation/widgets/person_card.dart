import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/person_entity.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;
  final VoidCallback? onTap;

  const PersonCard({super.key, required this.person, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100.w,
        child: Column(
          children: [
            // Circular photo
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white400.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: person.profilePath != null
                    ? CachedNetworkImage(
                        imageUrl: context.tmdbPosterUrl(person.profilePath),
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: AppColors.cardBackground),
                        errorWidget: (context, url, error) => Icon(
                          Icons.person,
                          color: AppColors.white400,
                          size: 40.sp,
                        ),
                      )
                    : Icon(
                        Icons.person,
                        color: AppColors.white400,
                        size: 40.sp,
                      ),
              ),
            ),
            SizedBox(height: 8.h),
            // Name
            Text(
              person.name,
              style: context.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
