import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/trending_movie_entity.dart';
import '../../../../core/models/trending_person_entity.dart';
import '../../../../core/models/trending_tv_entity.dart';
import '../../../../core/network/tmdb_service.dart';

class TrendingState {
  final List<TrendingMovieEntity> trendingMovies;
  final List<TrendingTVEntity> trendingTV;
  final List<TrendingPersonEntity> trendingPeople;
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
    List<TrendingMovieEntity>? trendingMovies,
    List<TrendingTVEntity>? trendingTV,
    List<TrendingPersonEntity>? trendingPeople,
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
                TrendingMovieEntity.fromJson(json as Map<String, dynamic>),
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
            (json) => TrendingTVEntity.fromJson(json as Map<String, dynamic>),
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
                TrendingPersonEntity.fromJson(json as Map<String, dynamic>),
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
