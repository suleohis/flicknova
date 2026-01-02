import 'package:fl_chart/fl_chart.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';

class GenreChart extends StatelessWidget {
  final Map<String, double> genreDistribution;

  const GenreChart({super.key, required this.genreDistribution});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    // Colors for each genre
    final genreColors = {
      'Sci-Fi': const Color(0xFF00D4FF), // Cyan
      'Drama': const Color(0xFF9D50FF), // Purple
      'Action': const Color(0xFF3B82F6), // Blue
      'Other': const Color(0xFF6B7280), // Gray
    };

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.favorite_genres, style: context.h3),
          SizedBox(height: 24.h),
          Row(
            children: [
              // Donut chart
              SizedBox(
                width: 140.r,
                height: 140.r,
                child: PieChart(
                  PieChartData(
                    sections: genreDistribution.entries.map((entry) {
                      return PieChartSectionData(
                        value: entry.value,
                        title: '',
                        color: genreColors[entry.key] ?? AppColors.white400,
                        radius: 40.r,
                      );
                    }).toList(),
                    centerSpaceRadius: 60.r,
                    sectionsSpace: 2,
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
              SizedBox(width: 24.w),
              // Legend
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: genreDistribution.entries.map((entry) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        children: [
                          Container(
                            width: 12.r,
                            height: 12.r,
                            decoration: BoxDecoration(
                              color:
                                  genreColors[entry.key] ?? AppColors.white400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(entry.key, style: context.bodyMedium),
                          ),
                          Text(
                            '${entry.value.toInt()}%',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
