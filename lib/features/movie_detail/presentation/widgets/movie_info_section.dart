import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/movie_detail_entity.dart';

class MovieInfoSection extends StatelessWidget {
  final MovieDetailEntity movie;

  const MovieInfoSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating row
          Row(
            children: [
              Icon(Icons.star, color: AppColors.rating, size: 20.sp),
              SizedBox(width: 6.w),
              Text(
                movie.voteAverage.toStringAsFixed(1),
                style: context.h4.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 4.w),
              Text(
                '/10',
                style: context.body.copyWith(color: AppColors.white600),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Meta info
          Wrap(
            spacing: 12.w,
            runSpacing: 8.h,
            children: [
              if (movie.releaseDate != null)
                _MetaChip(
                  icon: Icons.calendar_today,
                  label: movie.releaseDate!.split('-').first,
                ),
              if (movie.runtime != null)
                _MetaChip(
                  icon: Icons.access_time,
                  label: '${movie.runtime} min',
                ),
              ...movie.genres
                  .take(3)
                  .map((genre) => _GenreChip(label: genre.name)),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.chipBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: AppColors.metaIconColor),
          SizedBox(width: 6.w),
          Text(
            label,
            style: context.bodySmall.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  final String label;

  const _GenreChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.chipBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        label,
        style: context.bodySmall.copyWith(color: AppColors.white),
      ),
    );
  }
}
