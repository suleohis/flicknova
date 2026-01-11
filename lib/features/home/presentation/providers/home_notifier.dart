import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/person_entity.dart';
import '../../../../core/models/tv_show_entity.dart';
import '../../../watchlist/data/watchlist_service.dart';
import '../../../watchlist/domain/entities/watchlist_item_entity.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';

class HomeState {
  final List<Map<String, dynamic>> trendingAll;
  final List<MovieEntity> trendingMovies;
  final List<MovieEntity> popularMovies;
  final List<MovieEntity> topRatedMovies;
  final List<MovieEntity> newReleases;
  final List<TVShowEntity> popularTVShows;
  final List<TVShowEntity> trendingTVShows;
  final List<PersonEntity> popularPeople;
  final bool isLoadingTrending;
  final bool isLoadingPopular;
  final bool isLoadingTopRated;
  final bool isLoadingNewReleases;
  final String? error;
  final String? heroVideoKey; // YouTube video key for hero movie
  final bool hasHeroTrailer;
  final bool isInWatchlist;
  final bool isTogglingWatchlist;

  HomeState({
    this.trendingAll = const [],
    this.trendingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.newReleases = const [],
    this.popularTVShows = const [],
    this.trendingTVShows = const [],
    this.popularPeople = const [],
    this.isLoadingTrending = false,
    this.isLoadingPopular = false,
    this.isLoadingTopRated = false,
    this.isLoadingNewReleases = false,
    this.error,
    this.heroVideoKey,
    this.hasHeroTrailer = false,
    this.isInWatchlist = false,
    this.isTogglingWatchlist = false,
  });

  HomeState copyWith({
    List<Map<String, dynamic>>? trendingAll,
    List<MovieEntity>? trendingMovies,
    List<MovieEntity>? popularMovies,
    List<MovieEntity>? topRatedMovies,
    List<MovieEntity>? newReleases,
    List<TVShowEntity>? popularTVShows,
    List<TVShowEntity>? trendingTVShows,
    List<PersonEntity>? popularPeople,
    bool? isLoadingTrending,
    bool? isLoadingPopular,
    bool? isLoadingTopRated,
    bool? isLoadingNewReleases,
    String? error,
    String? heroVideoKey,
    bool? hasHeroTrailer,
    bool? isInWatchlist,
    bool? isTogglingWatchlist,
    bool? isLoading,
  }) {
    return HomeState(
      trendingAll: trendingAll ?? this.trendingAll,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      newReleases: newReleases ?? this.newReleases,
      popularTVShows: popularTVShows ?? this.popularTVShows,
      trendingTVShows: trendingTVShows ?? this.trendingTVShows,
      popularPeople: popularPeople ?? this.popularPeople,
      isLoadingTrending: isLoadingTrending ?? this.isLoadingTrending,
      isLoadingPopular: isLoadingPopular ?? this.isLoadingPopular,
      isLoadingTopRated: isLoadingTopRated ?? this.isLoadingTopRated,
      isLoadingNewReleases: isLoadingNewReleases ?? this.isLoadingNewReleases,
      error: error ?? this.error,
      heroVideoKey: heroVideoKey ?? this.heroVideoKey,
      hasHeroTrailer: hasHeroTrailer ?? this.hasHeroTrailer,
      isInWatchlist: isInWatchlist ?? this.isInWatchlist,
      isTogglingWatchlist: isTogglingWatchlist ?? this.isTogglingWatchlist,
    );
  }
}

class HomeNotifier extends Notifier<HomeState> {
  late final HomeRepository _repository;
  late final WatchlistService _watchlistService;

  @override
  HomeState build() {
    _repository = HomeRepositoryImpl();
    _watchlistService = WatchlistService();
    Future.delayed(Duration(seconds: 1), () => loadAllData());
    return HomeState();
  }

  Future<void> loadAllData() async {
    await Future.wait([
      loadTrendingAll(),
      loadTrendingMovies(),
      loadTrendingTVShows(),
      loadPopularMovies(),
      loadPopularTVShows(),
      loadPopularPeople(),
      loadTopRatedMovies(),
      loadNewReleases(),
    ]);
  }

  Future<void> loadTrendingAll() async {
    state = state.copyWith(isLoadingTrending: true);
    try {
      final all = await _repository.getTrendingAll();
      state = state.copyWith(trendingAll: all, isLoadingTrending: false);

      // Load video for hero movie (first trending movie)
      // if (all.isNotEmpty) {
      //   if (all.first['media_type'] == 'movie') {
      //     await _loadHeroVideo(all.first['id']);
      //   } else {
      //     await _loadTVShowHeroVideo(all.first['id']);
      //   }
      // }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoadingTrending: false);
      if (kDebugMode) {
        print('Error loading trending movies: $e');
      }
    }
  }

  Future<void> loadTrendingMovies() async {
    state = state.copyWith(isLoadingTrending: true);
    try {
      final movies = await _repository.getTrendingMovies();
      state = state.copyWith(trendingMovies: movies, isLoadingTrending: false);

      // Load video for hero movie (first trending movie)
      if (movies.isNotEmpty) {
        await _loadHeroVideo(movies.first.id);


        final isInWatchlist = await _watchlistService.isInWatchlist(
          tmdbId: movies.first.id,
          mediaType: movies.first.mediaType,
        );

        state = state.copyWith(
          isInWatchlist: isInWatchlist,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoadingTrending: false);
      if (kDebugMode) {
        print('Error loading trending movies: $e');
      }
    }
  }

  Future<void> _loadHeroVideo(int movieId) async {
    try {
      final videos = await _repository.getMovieVideos(movieId);
      // Find trailer video
      final trailer = videos.firstWhere(
        (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
        orElse: () => {},
      );

      if (trailer.isNotEmpty) {
        state = state.copyWith(
          heroVideoKey: trailer['key'] as String?,
          hasHeroTrailer: true,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading hero video: $e');
      }
    }
  }

  Future<void> _loadTVShowHeroVideo(int tvShowId) async {
    try {
      final videos = await _repository.getTVShowVideos(tvShowId);
      // Find trailer video
      final trailer = videos.firstWhere(
        (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
        orElse: () => {},
      );

      if (trailer.isNotEmpty) {
        state = state.copyWith(
          heroVideoKey: trailer['key'] as String?,
          hasHeroTrailer: true,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading hero video: $e');
      }
    }
  }

  Future<void> loadPopularMovies() async {
    state = state.copyWith(isLoadingPopular: true);
    try {
      final movies = await _repository.getPopularMovies();
      state = state.copyWith(popularMovies: movies, isLoadingPopular: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoadingPopular: false);
      if (kDebugMode) {
        print('Error loading popular movies: $e');
      }
    }
  }

  Future<void> loadPopularTVShows() async {
    try {
      final results = await _repository.getPopularTVShows();
      final tvShows = results
          .map((json) => TVShowEntity.fromJson(json as Map<String, dynamic>))
          .toList();
      state = state.copyWith(popularTVShows: tvShows);
    } catch (e) {
      if (kDebugMode) {
        print('Error loading popular TV shows: $e');
      }
    }
  }

  Future<void> loadTrendingTVShows() async {
    state = state.copyWith(isLoadingTrending: true);
    try {
      final movies = await _repository.getTrendingTVShows();
      state = state.copyWith(trendingTVShows: movies, isLoadingTrending: false);

      // Load video for hero movie (first trending movie)
      // if (movies.isNotEmpty) {
      //   await _loadHeroVideo(movies.first.id);
      // }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoadingTrending: false);
      if (kDebugMode) {
        print('Error loading trending movies: $e');
      }
    }
  }

  Future<void> loadPopularPeople() async {
    try {
      final results = await _repository.getPopularPeople();
      final people = results
          .map((json) => PersonEntity.fromJson(json as Map<String, dynamic>))
          .toList();
      state = state.copyWith(popularPeople: people);
    } catch (e) {
      if (kDebugMode) {
        print('Error loading popular people: $e');
      }
    }
  }

  Future<void> loadTopRatedMovies() async {
    state = state.copyWith(isLoadingTopRated: true);
    try {
      final movies = await _repository.getTopRatedMovies();
      state = state.copyWith(topRatedMovies: movies, isLoadingTopRated: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoadingTopRated: false);
      if (kDebugMode) {
        print('Error loading top rated movies: $e');
      }
    }
  }

  Future<void> loadNewReleases() async {
    state = state.copyWith(isLoadingNewReleases: true);
    try {
      final movies = await _repository.getNewReleases();
      state = state.copyWith(newReleases: movies, isLoadingNewReleases: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoadingNewReleases: false);
      if (kDebugMode) {
        print('Error loading new releases: $e');
      }
    }
  }

  Future<bool> toggleWatchlist(MovieEntity movie) async {

    state = state.copyWith(isTogglingWatchlist: true);

    try {
      if (state.isInWatchlist) {
        await _watchlistService.removeFromWatchlist(
          tmdbId: movie.id,
          mediaType: movie.mediaType,
        );
        state = state.copyWith(
          isInWatchlist: false,
          isTogglingWatchlist: false,
        );
      } else {
        // Create WatchlistItemEntity with proper data
        final userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId == null) {
          throw Exception('User not authenticated');
        }

        final watchlistItem = WatchlistItemEntity(
          userId: userId,
          tmdbId: movie.id,
          mediaType: movie.mediaType,
          title: movie.title,
          posterPath: movie.posterPath,
          addedAt: DateTime.now(),
          runtime: 0,
        );

        await _watchlistService.addToWatchlist(watchlistItem);
        state = state.copyWith(isInWatchlist: true, isTogglingWatchlist: false);
      }
      return true;
    } catch (e) {
      state = state.copyWith(isTogglingWatchlist: false);
      if (kDebugMode) {
        print('Error toggling watchlist: $e');
      }
      return false;
    }
  }
}

final homeProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
