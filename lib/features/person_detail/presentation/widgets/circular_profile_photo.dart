import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularProfilePhoto extends StatelessWidget {
  final String? profilePath;
  final double size;

  const CircularProfilePhoto({super.key, this.profilePath, this.size = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.white400.withValues(alpha: 0.2),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.background.withValues(alpha: 0.7),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipOval(
        child: profilePath != null
            ? CachedNetworkImage(
                imageUrl: context.tmdbPosterUrl(profilePath),
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
                    Icons.person_outline,
                    color: AppColors.white400,
                    size: (size * 0.5).sp,
                  ),
                ),
              )
            : Container(
                color: AppColors.cardBackground,
                child: Icon(
                  Icons.person_outline,
                  color: AppColors.white400,
                  size: (size * 0.5).sp,
                ),
              ),
      ),
    );
  }
}
