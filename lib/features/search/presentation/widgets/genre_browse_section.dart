import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';

class GenreBrowseSection extends StatelessWidget {
  final Function(String)? onGenreSelected;

  const GenreBrowseSection({super.key, this.onGenreSelected});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    final genres = [
      'Action',
      'Sci-Fi',
      'Comedy',
      'Drama',
      'Thriller',
      'Adventure',
      'Horror',
      'Romance',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(s.browse_by_genre, style: context.h3),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: genres.map((genre) {
              return GestureDetector(
                onTap: () => onGenreSelected?.call(genre),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.chipBackground,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Text(
                    genre,
                    style: context.bodyMedium.copyWith(color: AppColors.white),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
