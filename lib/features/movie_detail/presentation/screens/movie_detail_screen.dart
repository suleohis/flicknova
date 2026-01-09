import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/youtube_player_widget.dart';
import '../../../../shared/app_loading.dart';
import '../../../tv_detail/presentation/providers/tv_detail_notifier.dart';
import '../providers/movie_detail_notifier.dart';
import '../widgets/action_buttons_row.dart';
import '../widgets/cast_list.dart';
import '../widgets/detail_hero_section.dart';
import '../widgets/movie_info_section.dart';
import '../widgets/overview_section.dart';
import '../widgets/recommendations_section.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  ConsumerState<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Load movie details when screen initializes
    Future.microtask(() {
      ref.read(movieDetailProvider.notifier).loadMovieDetail(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(movieDetailProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: detailState.isLoading
          ? const Center(child: AppLoading())
          : detailState.movie == null
          ? Center(
              child: Text(
                detailState.error ?? 'Failed to load movie details',
                style: TextStyle(color: AppColors.white),
              ),
            )
          : CustomScrollView(
              slivers: [
                // Hero section
                SliverToBoxAdapter(
                  child: DetailHeroSection(movie: detailState.movie!),
                ),

                // Movie info
                SliverToBoxAdapter(
                  child: MovieInfoSection(movie: detailState.movie!),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 16.h)),

                // Action buttons
                SliverToBoxAdapter(
                  child: ActionButtonsRow(
                    onPlayTap:
                        (detailState.movie?.videos?.results.last.key != null)
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => YouTubePlayerWidget(
                                  videoKey:
                                      detailState
                                          .movie
                                          ?.videos
                                          ?.results
                                          .last
                                          .key ??
                                      '',
                                  title: detailState.movie?.title ?? '',
                                ),
                              ),
                            );
                          }
                        : null,
                    onWatchlistTap: () {
                      ref
                          .read(tvDetailProvider.notifier)
                          .toggleWatchlist();
                    },
                    onShareTap: () {
                      // TODO: Share movie
                    },
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                // Overview
                SliverToBoxAdapter(
                  child: OverviewSection(overview: detailState.movie!.overview),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                // Cast
                SliverToBoxAdapter(child: CastList(cast: detailState.cast)),

                SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                // Recommendations
                SliverToBoxAdapter(
                  child: RecommendationsSection(
                    recommendations: detailState.recommendations,
                    onMovieTap: (movie) {
                      // Navigate to this movie's detail page
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailScreen(movieId: movie.id),
                        ),
                      );
                    },
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 40.h)),
              ],
            ),
    );
  }
}
