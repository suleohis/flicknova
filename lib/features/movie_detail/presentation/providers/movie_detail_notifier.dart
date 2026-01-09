import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../data/repositories/movie_detail_repository_impl.dart';
import '../../domain/entities/cast_entity.dart';
import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/repositories/movie_detail_repository.dart';

class MovieDetailState {
  final MovieDetailEntity? movie;
  final List<CastEntity> cast;
  final List<MovieEntity> recommendations;
  final bool isLoading;
  final String? error;
  final bool isInWatchlist;
  final bool isTogglingWatchlist;

  MovieDetailState({
    this.movie,
    this.cast = const [],
    this.recommendations = const [],
    this.isLoading = false,
    this.error,
    this.isInWatchlist = false,
    this.isTogglingWatchlist = false,
  });

  MovieDetailState copyWith({
    MovieDetailEntity? movie,
    List<CastEntity>? cast,
    List<MovieEntity>? recommendations,
    bool? isLoading,
    String? error,
    bool? isInWatchlist,
    bool? isTogglingWatchlist,
  }) {
    return MovieDetailState(
      movie: movie ?? this.movie,
      cast: cast ?? this.cast,
      recommendations: recommendations ?? this.recommendations,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isInWatchlist: isInWatchlist ?? this.isInWatchlist,
      isTogglingWatchlist: isTogglingWatchlist ?? this.isTogglingWatchlist,
    );
  }
}

class MovieDetailNotifier extends Notifier<MovieDetailState> {
  late final MovieDetailRepository _repository;
  // late final WatchlistService _watchlistService;

  @override
  MovieDetailState build() {
    _repository = MovieDetailRepositoryImpl();
    // _watchlistService = WatchlistService();
    return MovieDetailState();
  }

  Future<void> loadMovieDetail(int movieId) async {
    state = state.copyWith(isLoading: true);

    try {
      final results = await Future.wait([
        _repository.getMovieDetail(movieId),
        _repository.getMovieCast(movieId),
        _repository.getRecommendations(movieId),
      ]);

      final isInWatchlist = ref.read(authProvider).profile?.watchList?.contains(
        (results[0]  as MovieDetailEntity).toJson(),
      ) ??
          false;

      state = state.copyWith(
        movie: results[0] as MovieDetailEntity,
        cast: results[1] as List<CastEntity>,
        recommendations: results[2] as List<MovieEntity>,
        isInWatchlist: isInWatchlist,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Error loading movie detail: $e');
      }
    }
  }

  Future<void> toggleWatchlist(BuildContext context) async {
    print('working');
    if (state.movie == null) return;
    print('working');

    state = state.copyWith(isTogglingWatchlist: true);

    try {
      final isInWatchlist = await ref
          .read(authProvider.notifier)
          .addWatchList(state.movie!.toJson());
      ref.read(authProvider.notifier).saveProfile(context, false);

      state = state.copyWith(
        isInWatchlist: isInWatchlist,
        isTogglingWatchlist: false,
      );
    } catch (e) {
      state = state.copyWith(isTogglingWatchlist: false);
      if (kDebugMode) {
        print('Error toggling watchlist: $e');
      }
    }
  }
}

final movieDetailProvider =
    NotifierProvider<MovieDetailNotifier, MovieDetailState>(
      MovieDetailNotifier.new,
    );
