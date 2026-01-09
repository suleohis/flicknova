import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/genre_model.dart';
import 'package:flicknova/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/search_notifier.dart';

class CategoryFilters extends StatelessWidget {
  final SearchState searchState;
  final ValueChanged<GenreModel> onCategorySelected;

  const CategoryFilters({
    super.key,
    required this.searchState,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: searchState.genres.length + 1,
        itemBuilder: (context, ind) {
          if (ind == 0) {
            return GestureDetector(
              onTap: () => onCategorySelected(GenreModel(id: 0, name: '')),
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: searchState.selectedGenres.isEmpty
                      ? AppColors.trendingBadge
                      : AppColors.chipBackground,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Center(
                  child: Text(
                    S.of(context).all,
                    style: context.bodyMedium.copyWith(
                      color: searchState.selectedGenres.isEmpty
                          ? AppColors.background
                          : AppColors.white,
                      fontWeight: searchState.selectedGenres.isEmpty
                          ? FontWeight.w600
                          : FontWeight.w400,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
            );
          }
          int index = ind - 1;
          final genre = searchState.genres[index];
          final isSelected = searchState.selectedGenres.contains(
            searchState.genres[index],
          );

          return GestureDetector(
            onTap: () => onCategorySelected(genre),
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.trendingBadge
                    : AppColors.chipBackground,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Center(
                child: Text(
                  genre.name!,
                  style: context.bodyMedium.copyWith(
                    color: isSelected ? AppColors.background : AppColors.white,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
