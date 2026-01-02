import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/home_repository_impl.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/home_repository.dart';

class HomeState {
  final List<MovieEntity> trendingMovies;
  final List<MovieEntity> popularMovies;
  final List<MovieEntity> topRatedMovies;
  final List<MovieEntity> newReleases;
  final bool isLoadingTrending;
  final bool isLoadingPopular;
  final bool isLoadingTopRated;
  final bool isLoadingNewReleases;
  final String? error;

  HomeState({
    this.trendingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.newReleases = const [],
    this.isLoadingTrending = false,
    this.isLoadingPopular = false,
    this.isLoadingTopRated = false,
    this.isLoadingNewReleases = false,
    this.error,
  });

  HomeState copyWith({
    List<MovieEntity>? trendingMovies,
    List<MovieEntity>? popularMovies,
    List<MovieEntity>? topRatedMovies,
    List<MovieEntity>? newReleases,
    bool? isLoadingTrending,
    bool? isLoadingPopular,
    bool? isLoadingTopRated,
    bool? isLoadingNewReleases,
    String? error,
  }) {
    return HomeState(
      trendingMovies: trendingMovies ?? this.trendingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      newReleases: newReleases ?? this.newReleases,
      isLoadingTrending: isLoadingTrending ?? this.isLoadingTrending,
      isLoadingPopular: isLoadingPopular ?? this.isLoadingPopular,
      isLoadingTopRated: isLoadingTopRated ?? this.isLoadingTopRated,
      isLoadingNewReleases: isLoadingNewReleases ?? this.isLoadingNewReleases,
      error: error ?? this.error,
    );
  }
}

class HomeNotifier extends Notifier<HomeState> {
  late final HomeRepository _repository;

  @override
  HomeState build() {
    _repository = HomeRepositoryImpl();
    loadAllData();
    return HomeState();
  }

  Future<void> loadAllData() async {
    await Future.wait([
      loadTrendingMovies(),
      loadPopularMovies(),
      loadTopRatedMovies(),
      loadNewReleases(),
    ]);
  }

  Future<void> loadTrendingMovies() async {
    state = state.copyWith(isLoadingTrending: true);
    try {
      final movies = await _repository.getTrendingMovies();
      state = state.copyWith(trendingMovies: movies, isLoadingTrending: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoadingTrending: false);
      if (kDebugMode) {
        print('Error loading trending movies: $e');
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
