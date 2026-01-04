import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/common_detail_entities.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenreChips extends StatelessWidget {
  final List<GenreEntity> genres;

  const GenreChips({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: genres.take(3).map((genre) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.chipBackground,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            genre.name,
            style: context.caption.copyWith(
              color: AppColors.white600,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }
}
