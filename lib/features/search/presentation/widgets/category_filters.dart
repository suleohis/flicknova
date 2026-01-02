import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class CategoryFilters extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryFilters({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'id': 'all', 'label': 'All'},
      {'id': 'movie', 'label': 'Movies'},
      {'id': 'tv', 'label': 'TV'},
      {'id': 'action', 'label': 'Action'},
      {'id': 'drama', 'label': 'Drama'},
      {'id': 'sci_fi', 'label': 'Sci-Fi'},
    ];

    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category['id'];

          return GestureDetector(
            onTap: () => onCategorySelected(category['id']!),
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.chipSelected
                    : AppColors.chipBackground,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: Text(
                  category['label']!,
                  style: context.bodyMedium.copyWith(
                    color: isSelected ? AppColors.background : AppColors.white,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
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
