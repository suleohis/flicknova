import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/tv_series_detail_entity.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TVMetadataRow extends StatelessWidget {
  final TVSeriesDetailEntity series;

  const TVMetadataRow({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    final year = series.firstAirDate?.split('-').first ?? '';
    final rating = series.voteAverage.toStringAsFixed(1);

    // Get average episode runtime
    final runtime = series.episodeRunTime.isNotEmpty
        ? '${series.episodeRunTime.first}m'
        : '';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Year
        if (year.isNotEmpty) ...[
          _buildMetadataItem(context, year),
          _buildDot(),
        ],
        // Rating
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: AppColors.rating, size: 14.sp),
            SizedBox(width: 4.w),
            _buildMetadataItem(context, rating),
          ],
        ),
        // Runtime
        if (runtime.isNotEmpty) ...[
          _buildDot(),
          _buildMetadataItem(context, runtime),
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
