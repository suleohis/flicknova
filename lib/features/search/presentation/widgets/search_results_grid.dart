import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';
import '../../../home/domain/entities/movie_entity.dart';
import '../../../home/presentation/widgets/movie_card.dart';

class SearchResultsGrid extends StatelessWidget {
  final List<MovieEntity> results;
  final Function(MovieEntity)? onMovieTap;

  const SearchResultsGrid({super.key, required this.results, this.onMovieTap});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Text(s.top_results, style: context.h3),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.58,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 20.h,
          ),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final movie = results[index];
            final showTrendingBadge = index == 0;

            return Stack(
              children: [
                MovieCard(movie: movie, onTap: () => onMovieTap?.call(movie)),
                if (showTrendingBadge)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.trendingBadge,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        s.trending.toUpperCase(),
                        style: context.caption.copyWith(
                          color: AppColors.background,
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
