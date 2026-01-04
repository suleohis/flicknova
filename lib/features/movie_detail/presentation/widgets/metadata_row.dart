import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/movie_detail_entity.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MetadataRow extends StatelessWidget {
  final MovieDetailEntity movie;

  const MetadataRow({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final year = movie.releaseDate?.split('-').first ?? '';
    final runtime = movie.runtime != null ? '${movie.runtime}min' : '';

    // Get age rating (you might want to calculate this from movie.adult or other fields)
    final ageRating = movie.adult ? '18+' : '13+';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Year
        if (year.isNotEmpty) ...[
          _buildMetadataItem(context, year),
          _buildDot(),
        ],
        // Age rating
        _buildMetadataChip(context, ageRating),
        _buildDot(),
        // Runtime
        if (runtime.isNotEmpty) ...[
          _buildMetadataItem(context, runtime),
          _buildDot(),
        ],
      ],
    );
  }

  Widget _buildMetadataItem(BuildContext context, String text) {
    return Text(
      text,
      style: context.bodySmall.copyWith(
        color: AppColors.white600,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildMetadataChip(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white400.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        text,
        style: context.caption.copyWith(
          color: AppColors.white600,
          fontWeight: FontWeight.w600,
          fontSize: 10.sp,
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        width: 3.w,
        height: 3.w,
        decoration: const BoxDecoration(
          color: AppColors.white600,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
