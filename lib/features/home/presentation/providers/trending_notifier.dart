import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/person_entity.dart';
import '../../../../core/models/tv_show_entity.dart';
import '../../../../core/network/tmdb_service.dart';

class TrendingState {
  final List<MovieEntity> trendingMovies;
  final List<TVShowEntity> trendingTV;
  final List<PersonEntity> trendingPeople;
  final bool isLoading;
  final String? error;

  TrendingState({
    this.trendingMovies = const [],
    this.trendingTV = const [],
    this.trendingPeople = const [],
    this.isLoading = false,
    this.error,
  });

  TrendingState copyWith({
    List<MovieEntity>? trendingMovies,
    List<TVShowEntity>? trendingTV,
    List<PersonEntity>? trendingPeople,
    bool? isLoading,
    String? error,
  }) {
    return TrendingState(
      trendingMovies: trendingMovies ?? this.trendingMovies,
      trendingTV: trendingTV ?? this.trendingTV,
      trendingPeople: trendingPeople ?? this.trendingPeople,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class TrendingNotifier extends Notifier<TrendingState> {
  late final TmdbService _tmdbService;

  @override
  TrendingState build() {
    _tmdbService = TmdbService();
    loadAllTrending();
    return TrendingState();
  }

  Future<void> loadAllTrending() async {
    state = state.copyWith(isLoading: true);

    try {
      await Future.wait([
        loadTrendingMovies(),
        loadTrendingTV(),
        loadTrendingPeople(),
      ]);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Load all trending error: $e');
      }
    }
  }

  Future<void> loadTrendingMovies() async {
    try {
      final data = await _tmdbService.getTrendingMovies(timeWindow: 'day');
      final movies = (data['results'] as List)
          .map(
            (json) =>
                MovieEntity.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      state = state.copyWith(trendingMovies: movies);
    } catch (e) {
      if (kDebugMode) {
        print('Load trending movies error: $e');
      }
    }
  }

  Future<void> loadTrendingTV() async {
    try {
      final data = await _tmdbService.getTrendingTV(timeWindow: 'day');
      final tvShows = (data['results'] as List)
          .map(
            (json) => TVShowEntity.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      state = state.copyWith(trendingTV: tvShows);
    } catch (e) {
      if (kDebugMode) {
        print('Load trending TV error: $e');
      }
    }
  }

  Future<void> loadTrendingPeople() async {
    try {
      final data = await _tmdbService.getTrendingPeople(timeWindow: 'day');
      final people = (data['results'] as List)
          .map(
            (json) =>
                PersonEntity.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      state = state.copyWith(trendingPeople: people);
    } catch (e) {
      if (kDebugMode) {
        print('Load trending people error: $e');
      }
    }
  }

  Future<void> refresh() async {
    await loadAllTrending();
  }
}

final trendingProvider = NotifierProvider<TrendingNotifier, TrendingState>(
  TrendingNotifier.new,
);
