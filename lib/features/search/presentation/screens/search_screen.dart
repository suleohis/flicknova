import 'package:flicknova/core/models/tv_show_entity.dart';
import 'package:flicknova/features/tv_detail/presentation/screens/tv_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/providers/home_notifier.dart';
import '../../../movie_detail/presentation/screens/movie_detail_screen.dart';
import '../providers/recently_viewed_provider.dart';
import '../providers/search_notifier.dart';
import '../widgets/category_filters.dart';
import '../widgets/genre_browse_section.dart';
import '../widgets/recently_viewed_section.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/search_results_grid.dart';
import '../widgets/trending_searches_section.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);
    final recentlyViewed = ref.watch(recentlyViewedProvider);
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(homeProvider.notifier).loadAllData();
          ref.read(searchProvider.notifier).loadAllData();
        },
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: SafeArea(
          child: Column(
            children: [
              // Search bar
              SearchBarWidget(
                onChanged: (query) {
                  ref.read(searchProvider.notifier).updateQuery(query);
                },
              ),

              // Show different content based on search state
              Expanded(
                child: searchState.showResults
                    ? _buildSearchResults(searchState)
                    : _buildInitialState(
                        recentlyViewed,
                        homeState,
                        searchState,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(SearchState searchState) {
    return CustomScrollView(
      slivers: [
        // Category filters
        SliverToBoxAdapter(
          child: CategoryFilters(
            searchState: searchState,
            onCategorySelected: (category) {
              ref.read(searchProvider.notifier).selectedGenreOnTap(category);
            },

          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 16.h)),

        // Results grid
        if (searchState.isSearching)
          const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          )
        else if (searchState.results.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Text(
                'No results found',
                style: TextStyle(color: AppColors.white600),
              ),
            ),
          )
        else
          SliverToBoxAdapter(
            child: SearchResultsGrid(
              results: searchState.results.where((genre) {
                if (searchState.selectedGenres.isEmpty)
                  {
                    return true;
                  }
                else {
                  if (genre is MovieEntity) {
                    return searchState.selectedGenres.any((selectedGenre) {
                      return genre.genreIds.contains(selectedGenre.id);
                    });
                  }
                  if (genre is TVShowEntity) {
                    return searchState.selectedGenres.any((selectedGenre) {
                      return genre.genreIds.contains(selectedGenre.id);
                    });
                  }
                  return false;
                }
              }).toList(),
              onItemTap: (item) {
                // Add to recently viewed if it's a movie
                if (item is MovieEntity) {
                  ref.read(recentlyViewedProvider.notifier).addMovie(item);
                }
              },
            ),
          ),
      ],
    );
  }

  Widget _buildInitialState(
    List<MovieEntity> recentlyViewed,
    HomeState homeState,
    SearchState searchState,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recently viewed
          if (recentlyViewed.isNotEmpty) ...[
            RecentlyViewedSection(
              movies: recentlyViewed,
              onClear: () {
                ref.read(recentlyViewedProvider.notifier).clear();
              },
              onMovieTap: (movie) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(movieId: movie.id),
                  ),
                );
              },
            ),
            SizedBox(height: 32.h),
          ],

          // Trending searches (using trending movies from home)
          if (homeState.trendingMovies.isNotEmpty ||
              homeState.trendingTVShows.isNotEmpty ||
              homeState.trendingAll.isNotEmpty) ...[
            TrendingSearchesSection(
              trendingAll: homeState.trendingAll,
              trendingMovies: homeState.trendingMovies,
              trendingTVShows: homeState.trendingTVShows,

              onMovieTap: (movie) {
                ref.read(recentlyViewedProvider.notifier).addMovie(movie);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(movieId: movie.id),
                  ),
                );
              },
              onTVShowTap: (tvShow) {
                // ref.read(recentlyViewedProvider.notifier).add(movie);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TVDetailScreen(seriesId: tvShow.id),
                  ),
                );
              },

            ),
            SizedBox(height: 32.h),
          ],

          // Browse by genre
          GenreBrowseSection(
            genres: searchState.genres,
            selectedGenres: searchState.selectedGenres,
            onGenreSelected: (genre) {
             ref.read(searchProvider.notifier).selectedGenreOnTap(genre);
            },
          ),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
