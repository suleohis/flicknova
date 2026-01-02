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
                  onPlayTrailerTap: () {
                    // TODO: Navigate to trailer player
                  },
                  onAddTap: () {
                    // TODO: Add to watchlist
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
                  // TODO: Navigate to see all trending
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

            // Popular on Crackshaft
            SliverToBoxAdapter(
              child: SectionHeader(
                title: s.popular_on_crackshaft,
                onSeeAllTap: () {
                  // TODO: Navigate to see all popular
                },
              ),
            ),
            if (homeState.isLoadingPopular)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 300.h,
                  child: Center(child: AppLoading()),
                ),
              )
            else
              SliverToBoxAdapter(
                child: PopularSection(
                  movies: homeState.popularMovies,
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

            SliverToBoxAdapter(child: SizedBox(height: 32.h)),

            // Top 10 in Your Country
            SliverToBoxAdapter(
              child: SectionHeader(
                title: s.top_10_in_your_country,
                onSeeAllTap: () {
                  // TODO: Navigate to see all top 10
                },
              ),
            ),
            if (homeState.isLoadingTopRated)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200.h,
                  child: Center(child: AppLoading()),
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final movie = homeState.topRatedMovies[index];
                    return TopTenItem(
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
                    );
                  }, childCount: homeState.topRatedMovies.take(10).length),
                ),
              ),

            SliverToBoxAdapter(child: SizedBox(height: 32.h)),

            // New Releases
            SliverToBoxAdapter(
              child: SectionHeader(
                title: s.new_releases,
                onSeeAllTap: () {
                  // TODO: Navigate to see all new releases
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
