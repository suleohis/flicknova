import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/person_entity.dart';
import '../../../../core/models/tv_show_entity.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';

class HomeState {
  final List<MovieEntity> trendingMovies;
  final List<MovieEntity> popularMovies;
  final List<MovieEntity> topRatedMovies;
  final List<MovieEntity> newReleases;
  final List<TVShowEntity> popularTVShows;
  final List<PersonEntity> popularPeople;
  final bool isLoadingTrending;
  final bool isLoadingPopular;
  final bool isLoadingTopRated;
  final bool isLoadingNewReleases;
  final String? error;
  final String? heroVideoKey; // YouTube video key for hero movie
  final bool hasHeroTrailer;

  HomeState({
    this.trendingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.newReleases = const [],
    this.popularTVShows = const [],
    this.popularPeople = const [],
    this.isLoadingTrending = false,
    this.isLoadingPopular = false,
    this.isLoadingTopRated = false,
    this.isLoadingNewReleases = false,
    this.error,
    this.heroVideoKey,
    this.hasHeroTrailer = false,
  });

  HomeState copyWith({
    List<MovieEntity>? trendingMovies,
    List<MovieEntity>? popularMovies,
    List<MovieEntity>? topRatedMovies,
    List<MovieEntity>? newReleases,
    List<TVShowEntity>? popularTVShows,
    List<PersonEntity>? popularPeople,
    bool? isLoadingTrending,
    bool? isLoadingPopular,
    bool? isLoadingTopRated,
    bool? isLoadingNewReleases,
    String? error,
    String? heroVideoKey,
    bool? hasHeroTrailer,
  }) {
    return HomeState(
      trendingMovies: trendingMovies ?? this.trendingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      newReleases: newReleases ?? this.newReleases,
      popularTVShows: popularTVShows ?? this.popularTVShows,
      popularPeople: popularPeople ?? this.popularPeople,
      isLoadingTrending: isLoadingTrending ?? this.isLoadingTrending,
      isLoadingPopular: isLoadingPopular ?? this.isLoadingPopular,
      isLoadingTopRated: isLoadingTopRated ?? this.isLoadingTopRated,
      isLoadingNewReleases: isLoadingNewReleases ?? this.isLoadingNewReleases,
      error: error ?? this.error,
      heroVideoKey: heroVideoKey ?? this.heroVideoKey,
      hasHeroTrailer: hasHeroTrailer ?? this.hasHeroTrailer,
    );
  }
}

class HomeNotifier extends Notifier<HomeState> {
  late final HomeRepository _repository;

  @override
  HomeState build() {
    _repository = HomeRepositoryImpl();
    Future.delayed(Duration(seconds: 1), () => loadAllData());
    return HomeState();
  }

  Future<void> loadAllData() async {
    await Future.wait([
      loadTrendingMovies(),
      loadPopularMovies(),
      loadPopularTVShows(),
      loadPopularPeople(),
      loadTopRatedMovies(),
      loadNewReleases(),
    ]);
  }

  Future<void> loadTrendingMovies() async {
    state = state.copyWith(isLoadingTrending: true);
    try {
      final movies = await _repository.getTrendingMovies();
      state = state.copyWith(trendingMovies: movies, isLoadingTrending: false);

      // Load video for hero movie (first trending movie)
      if (movies.isNotEmpty) {
        await _loadHeroVideo(movies.first.id);
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
}

final homeProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
