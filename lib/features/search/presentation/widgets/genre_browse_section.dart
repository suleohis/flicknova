import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/genre_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';

class GenreBrowseSection extends StatelessWidget {
  final Function(GenreModel)? onGenreSelected;
  final List<GenreModel> genres;
  final List<GenreModel> selectedGenres;

  const GenreBrowseSection({super.key, this.onGenreSelected, required this.genres, required this.selectedGenres});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

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
              bool isSelected = selectedGenres.contains(genre);
              return GestureDetector(
                onTap: () => onGenreSelected?.call(genre),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.trendingBadge
                        : AppColors.chipBackground,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Text(
                    genre.name,
                    style: context.bodyMedium.copyWith(
                      color: isSelected ? AppColors.background : AppColors.white,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,),
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
