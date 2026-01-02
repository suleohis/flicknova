import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';
import '../../../home/domain/entities/movie_entity.dart';
import 'trending_search_item.dart';

class TrendingSearchesSection extends StatefulWidget {
  final List<MovieEntity> trendingMovies;
  final Function(MovieEntity)? onMovieTap;

  const TrendingSearchesSection({
    super.key,
    required this.trendingMovies,
    this.onMovieTap,
  });

  @override
  State<TrendingSearchesSection> createState() =>
      _TrendingSearchesSectionState();
}

class _TrendingSearchesSectionState extends State<TrendingSearchesSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(s.trending_searches, style: context.h3),
        ),
        SizedBox(height: 12.h),
        TabBar(
          controller: _tabController,
          isScrollable: true,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          labelColor: AppColors.trendingBadge,
          unselectedLabelColor: AppColors.white600,
          indicatorColor: AppColors.trendingBadge,
          labelStyle: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          unselectedLabelStyle: context.bodyMedium,
          tabs: [
            Tab(text: s.top),
            Tab(text: s.movies),
            Tab(text: s.shows),
          ],
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 450.h,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTrendingList(widget.trendingMovies),
              _buildTrendingList(widget.trendingMovies),
              _buildTrendingList(widget.trendingMovies),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingList(List<MovieEntity> movies) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: movies.take(4).length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return TrendingSearchItem(
          movie: movie,
          rank: index + 1,
          onTap: () => widget.onMovieTap?.call(movie),
        );
      },
    );
  }
}
