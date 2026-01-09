import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/tv_show_entity.dart';
import 'package:flicknova/features/home/data/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';
import 'trending_search_item.dart';

enum SearchType { all, movie, tvShow }

class TrendingSearchesSection extends StatefulWidget {
  final List<Map<String, dynamic>> trendingAll;
  final List<MovieEntity> trendingMovies;
  final Function(MovieEntity)? onMovieTap;
  final List<TVShowEntity> trendingTVShows;
  final Function(TVShowEntity)? onTVShowTap;

  const TrendingSearchesSection({
    super.key,
    required this.trendingAll,
    required this.trendingMovies,
    this.onMovieTap,
    required this.trendingTVShows,
    this.onTVShowTap,
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
        Row(
          children: [
            Expanded(
              child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(s.trending_searches, style: context.h4),
                        ),
            ),
            Expanded(
              child: TabBar(
                controller: _tabController,
                isScrollable: false,
                padding: EdgeInsets.symmetric(horizontal: 0.w),
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
            ),
          ],
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 450.h,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTrendingAllList(widget.trendingAll),
              _buildTrendingMoviesList(widget.trendingMovies),
              _buildTrendingSeriesList(widget.trendingTVShows),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingAllList(List<Map<String, dynamic>> all) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: all.take(5).length,
      itemBuilder: (context, index) {
        final mediaType = all[index]['media_type'];
        final item = mediaType == 'movie'
            ? MovieModel.fromJson(all[index])
            : TVShowEntity.fromJson(all[index]);
        final type = mediaType == 'movie'
            ? SearchType.movie
            : SearchType.tvShow;
        return TrendingSearchItem(
          movie: type == SearchType.movie ? item as MovieModel : null,
          ser: type == SearchType.movie ? null : item as TVShowEntity,
          rank: index + 1,
          type: type,
          onTap: type == SearchType.movie
              ? () => widget.onMovieTap?.call(item as MovieModel)
              : () => widget.onTVShowTap?.call(item as TVShowEntity),
        );
      },
    );
  }

  Widget _buildTrendingMoviesList(List<MovieEntity> movies) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: movies.take(5).length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return TrendingSearchItem(
          movie: movie,
          rank: index + 1,
          type: SearchType.movie,
          onTap: () => widget.onMovieTap?.call(movie),
        );
      },
    );
  }

  Widget _buildTrendingSeriesList(List<TVShowEntity> series) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: series.take(5).length,
      itemBuilder: (context, index) {
        final ser = series[index];
        return TrendingSearchItem(
          ser: ser,
          rank: index + 1,
          type: SearchType.tvShow,
          onTap: () => widget.onTVShowTap?.call(ser),
        );
      },
    );
  }
}
