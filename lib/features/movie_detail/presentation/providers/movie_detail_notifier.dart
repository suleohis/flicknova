import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/domain/entities/movie_entity.dart';
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

  MovieDetailState({
    this.movie,
    this.cast = const [],
    this.recommendations = const [],
    this.isLoading = false,
    this.error,
  });

  MovieDetailState copyWith({
    MovieDetailEntity? movie,
    List<CastEntity>? cast,
    List<MovieEntity>? recommendations,
    bool? isLoading,
    String? error,
  }) {
    return MovieDetailState(
      movie: movie ?? this.movie,
      cast: cast ?? this.cast,
      recommendations: recommendations ?? this.recommendations,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class MovieDetailNotifier extends Notifier<MovieDetailState> {
  late final MovieDetailRepository _repository;

  @override
  MovieDetailState build() {
    _repository = MovieDetailRepositoryImpl();
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

      state = state.copyWith(
        movie: results[0] as MovieDetailEntity,
        cast: results[1] as List<CastEntity>,
        recommendations: results[2] as List<MovieEntity>,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Error loading movie detail: $e');
      }
    }
  }
}

final movieDetailProvider =
    NotifierProvider<MovieDetailNotifier, MovieDetailState>(
      MovieDetailNotifier.new,
    );
