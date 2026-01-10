import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/person_entity.dart';
import '../../../../core/models/tv_show_entity.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';
import '../../../../routes/app_router.dart';
import '../../../home/presentation/widgets/movie_card.dart';
import '../../../home/presentation/widgets/person_card.dart';
import '../../../home/presentation/widgets/tv_card.dart';
import '../../../movie_detail/presentation/screens/movie_detail_screen.dart';
import '../../../person_detail/presentation/screens/person_detail_screen.dart';
import '../../../tv_detail/presentation/screens/tv_detail_screen.dart';

class SearchResultsGrid extends StatelessWidget {
  final List<dynamic>
  results; // Can be MovieEntity, TVShowEntity, or PersonEntity
  final Function(dynamic)? onItemTap;

  const SearchResultsGrid({super.key, required this.results, this.onItemTap});

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
            childAspectRatio: 0.6,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 16.h,
          ),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final item = results[index];
            final showTrendingBadge = index == 0;

            return _buildGridItem(context, item, showTrendingBadge, onItemTap);
          },
        ),
      ],
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    dynamic item,
    bool showTrendingBadge,
    Function(dynamic)? onTap,
  ) {
    Widget card;

    if (item is MovieEntity) {
      card = MovieCard(
        movie: item,
        onTap: () {
          onTap?.call(item);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                movieId: item.id,
                mediaType: item.mediaType,
              ),
            ),
          );
        },
      );
    } else if (item is TVShowEntity) {
      card = TVCard(
        tvShow: item,
        width: double.infinity,
        height: 180.h,
        onTap: () {
          onTap?.call(item);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TVDetailScreen(seriesId: item.id),
            ),
          );
        },
      );
    } else if (item is PersonEntity) {
      card = PersonCard(
        person: item,
        onTap: () {
          onTap?.call(item);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PersonDetailScreen(personId: item.id),
            ),
          );
        },
      );
    } else {
      return const SizedBox.shrink();
    }

    // Wrap with trending badge
    if (showTrendingBadge && item is! PersonEntity) {
      return Stack(
        children: [
          card,
          Positioned(
            top: 8.h,
            left: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.trendingBadge,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                'TRENDING',
                style: TextStyle(
                  color: AppColors.background,
                  fontWeight: FontWeight.w700,
                  fontSize: 9.sp,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return card;
  }
}
