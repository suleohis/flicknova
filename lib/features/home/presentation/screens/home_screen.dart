import 'package:flicknova/core/widgets/youtube_player_widget.dart';
import 'package:flicknova/features/watchlist/data/watchlist_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/app_localizations.dart';
import '../../../../shared/app_loading.dart';
import '../../../movie_detail/presentation/screens/movie_detail_screen.dart';
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
                    final watchlistService = WatchlistService();
                    final movie = homeState.trendingMovies.first;

                    try {
                      final isInWatchlist = await watchlistService
                          .isInWatchlist(movie.id);

                      if (isInWatchlist) {
                        await watchlistService.removeFromWatchlist(movie.id);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Removed from watchlist')),
                          );
                        }
                      } else {
                        await watchlistService.addToWatchlist(
                          movieId: movie.id,
                          movieTitle: movie.title,
                          posterPath: movie.posterPath,
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Added to watchlist')),
                          );
                        }
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}')),
                        );
                      }
                    }
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          movieId: homeState.trendingMovies.first.id,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailScreen(movieId: movie.id),
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
                        builder: (context) =>
                            MovieDetailScreen(movieId: movie.id),
                      ),
                    );
                  },
                  onTVTap: (tvShow) {
                    // TODO: Navigate to TV detail
                  },
                  onPersonTap: (person) {
                    // TODO: Navigate to person detail
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
                      return Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: TopTenItem(
                          rank: index + 1,
                          movie: movie,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailScreen(movieId: movie.id),
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
      ),
    );
  }
}
