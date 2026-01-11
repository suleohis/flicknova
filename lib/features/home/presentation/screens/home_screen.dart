import 'package:flicknova/core/widgets/youtube_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/firebase_analytics_service.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../generated/app_localizations.dart';
import '../../../../routes/app_router.dart';
import '../../../../shared/app_loading.dart';
import '../../../movie_detail/presentation/screens/movie_detail_screen.dart';
import '../../../person_detail/presentation/screens/person_detail_screen.dart';
import '../../../tv_detail/presentation/screens/tv_detail_screen.dart';
import '../providers/home_notifier.dart';
import '../widgets/hero_section.dart';
import '../widgets/popular_section.dart';
import '../widgets/section_header.dart';
import '../widgets/top_ten_item.dart';
import '../widgets/trending_carousel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final homeState = ref.watch(homeProvider);

    // Track screen view
    FirebaseAnalyticsService.instance.logScreenView('home_screen');

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(homeProvider.notifier).loadAllData();
        },
        child: CustomScrollView(
          slivers: [
            // Hero section
            if (homeState.trendingMovies.isNotEmpty)
              SliverToBoxAdapter(
                child: HeroSection(
                  isInWatchlist: homeState.isInWatchlist,
                  isTogglingWatchlist: homeState.isTogglingWatchlist,
                  movie: homeState.trendingMovies.first,
                  hasTrailer: homeState.hasHeroTrailer,
                  onPlayTrailerTap: homeState.heroVideoKey != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => YouTubePlayerWidget(
                                videoKey: homeState.heroVideoKey!,
                                title: homeState.trendingMovies.first.title,
                              ),
                            ),
                          );
                        }
                      : null,
                  onAddTap: () async {
                    bool value = await ref
                        .read(homeProvider.notifier)
                        .toggleWatchlist(homeState.trendingMovies.first);
                    final s = S.of(context);

                    if (value) {
                      NotificationService.showSuccess(
                        context: context,
                        message:
                            '${homeState.trendingMovies.first.title} '
                            '${homeState.isInWatchlist ? s.removed : s.added}',
                        title: s.success,
                      );
                    } else {
                      NotificationService.showError(
                        context: context,
                        message: s.something_went_wrong,
                        title: s.error,
                      );
                    }
                  },
                  onTap: () {
                    final movie = homeState.trendingMovies.first;
                    FirebaseAnalyticsService.instance.logMovieView(
                      movieId: movie.id,
                      title: movie.title,
                      rating: movie.voteAverage,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          movieId: movie.id,
                          mediaType: movie.mediaType,
                        ),
                      ),
                    );
                  },
                ),
              )
            else if (homeState.isLoadingTrending)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 500.h,
                  child: Center(child: AppLoading()),
                ),
              ),

            // Trending Now
            SliverToBoxAdapter(
              child: SectionHeader(
                title: s.trending_now,
                onSeeAllTap: () {
                  context.push(
                    '${AppRouter.seeAll}?contentType=movie&category=trending&title=Trending Movies',
                  );
                },
              ),
            ),
            if (homeState.isLoadingTrending)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 270.h,
                  child: Center(child: AppLoading()),
                ),
              )
            else
              SliverToBoxAdapter(
                child: TrendingCarousel(
                  movies: homeState.trendingMovies,
                  onMovieTap: (movie) {
                    FirebaseAnalyticsService.instance.logMovieView(
                      movieId: movie.id,
                      title: movie.title,
                      rating: movie.voteAverage,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          movieId: movie.id,
                          mediaType: movie.mediaType,
                        ),
                      ),
                    );
                  },
                ),
              ),

            SliverToBoxAdapter(child: SizedBox(height: 24.h)),

            // Popular on FlickNova
            if (homeState.isLoadingPopular)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 300.h,
                  child: const Center(child: AppLoading()),
                ),
              )
            else
              SliverToBoxAdapter(
                child: PopularSection(
                  popularMovies: homeState.popularMovies,
                  popularTVShows: homeState.popularTVShows,
                  popularPeople: homeState.popularPeople,
                  onMovieTap: (movie) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          movieId: movie.id,
                          mediaType: movie.mediaType,
                        ),
                      ),
                    );
                  },
                  onTVTap: (tvShow) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TVDetailScreen(seriesId: tvShow.id),
                      ),
                    );
                  },
                  onPersonTap: (person) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PersonDetailScreen(personId: person.id),
                      ),
                    );
                  },
                ),
              ),

            SliverToBoxAdapter(child: SizedBox(height: 32.h)),

            // Top 10 in Your Country
            SliverToBoxAdapter(
              child: SectionHeader(
                title: s.top_10_in_your_country,
                onSeeAllTap: () {
                  context.push(
                    '${AppRouter.seeAll}?contentType=movie&category=top_rated&title=Top Rated Movies',
                  );
                },
              ),
            ),
            if (homeState.isLoadingTopRated)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 210.h,
                  child: const Center(child: AppLoading()),
                ),
              )
            else
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 210.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: homeState.topRatedMovies.take(10).length,
                    itemBuilder: (context, index) {
                      final movie = homeState.topRatedMovies[index];
                      return Container(
                        width: 340.w,
                        padding: EdgeInsets.only(right: 12.w),
                        child: TopTenItem(
                          rank: index + 1,
                          movie: movie,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(
                                  movieId: movie.id,
                                  mediaType: movie.mediaType,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),

            SliverToBoxAdapter(child: SizedBox(height: 32.h)),

            // New Releases
            SliverToBoxAdapter(
              child: SectionHeader(
                title: s.new_releases,
                onSeeAllTap: () {
                  context.push(
                    '${AppRouter.seeAll}?contentType=movie&category=upcoming&title=Upcoming Movies',
                  );
                },
              ),
            ),
            if (homeState.isLoadingNewReleases)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 270.h,
                  child: Center(child: AppLoading()),
                ),
              )
            else
              SliverToBoxAdapter(
                child: TrendingCarousel(
                  movies: homeState.newReleases,
                  onMovieTap: (movie) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          movieId: movie.id,
                          mediaType: movie.mediaType,
                        ),
                      ),
                    );
                  },
                ),
              ),

            SliverToBoxAdapter(child: SizedBox(height: 40.h)),
          ],
        ),
      ),
    );
  }
}
