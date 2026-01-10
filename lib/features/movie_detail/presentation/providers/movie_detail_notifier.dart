import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/services/notification_service.dart';
import '../../../watchlist/data/watchlist_service.dart';
import '../../../watchlist/domain/entities/watchlist_item_entity.dart';
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
  late final WatchlistService _watchlistService;

  @override
  MovieDetailState build() {
    _repository = MovieDetailRepositoryImpl();
    _watchlistService = WatchlistService();
    return MovieDetailState();
  }

  Future<void> loadMovieDetail(int movieId, String mediaType) async {
    state = state.copyWith(isLoading: true);

    try {
      final results = await Future.wait([
        _repository.getMovieDetail(movieId),
        _repository.getMovieCast(movieId),
        _repository.getRecommendations(movieId),
        _watchlistService.isInWatchlist(tmdbId: movieId, mediaType: mediaType),
      ]);

      state = state.copyWith(
        movie: results[0] as MovieDetailEntity,
        cast: results[1] as List<CastEntity>,
        recommendations: results[2] as List<MovieEntity>,
        isInWatchlist: results[3] as bool,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Error loading movie detail: $e');
      }
    }
  }

  Future<bool> toggleWatchlist() async {
    if (state.movie == null) return false;

    state = state.copyWith(isTogglingWatchlist: true);

    try {
      if (state.isInWatchlist) {
        await _watchlistService.removeFromWatchlist(
          tmdbId: state.movie!.id,
          mediaType: 'movie',
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
          tmdbId: state.movie!.id,
          mediaType: 'movie',
          title: state.movie!.title,
          posterPath: state.movie!.posterPath,
          addedAt: DateTime.now(),
          runtime: state.movie!.runtime,
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

final movieDetailProvider =
    NotifierProvider<MovieDetailNotifier, MovieDetailState>(
      MovieDetailNotifier.new,
    );
