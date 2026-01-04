import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/person_entity.dart';
import '../../../../core/models/tv_show_entity.dart';
import '../../../../core/network/tmdb_service.dart';

enum ContentType { movie, tv, person }

enum ContentCategory {
  trending,
  popular,
  topRated,
  upcoming,
  nowPlaying,
  onAir,
}

class SeeAllState {
  final List<dynamic> items;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;
  final String? error;

  SeeAllState({
    this.items = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 1,
    this.error,
  });

  SeeAllState copyWith({
    List<dynamic>? items,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
    String? error,
  }) {
    return SeeAllState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      error: error,
    );
  }
}

class SeeAllNotifier extends StateNotifier<SeeAllState> {
  final TmdbService _tmdbService;
  ContentType? _contentType;
  ContentCategory? _category;

  SeeAllNotifier(this._tmdbService) : super(SeeAllState());

  void initialize(ContentType contentType, ContentCategory category) {
    _contentType = contentType;
    _category = category;
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final items = await _fetchData(page: 1);
      state = state.copyWith(
        items: items,
        isLoading: false,
        currentPage: 1,
        hasMore: items.length >= 20,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load content. Please try again.',
      );
      if (kDebugMode) {
        print('Error loading initial data: $e');
      }
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final nextPage = state.currentPage + 1;
      final newItems = await _fetchData(page: nextPage);

      state = state.copyWith(
        items: [...state.items, ...newItems],
        isLoading: false,
        currentPage: nextPage,
        hasMore: newItems.length >= 20,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      if (kDebugMode) {
        print('Error loading more data: $e');
      }
    }
  }

  Future<List<dynamic>> _fetchData({required int page}) async {
    if (_contentType == null || _category == null) return [];

    switch (_contentType!) {
      case ContentType.movie:
        return await _fetchMovies(page);
      case ContentType.tv:
        return await _fetchTVShows(page);
      case ContentType.person:
        return await _fetchPeople(page);
    }
  }

  Future<List<MovieEntity>> _fetchMovies(int page) async {
    switch (_category!) {
      case ContentCategory.trending:
        final response = await _tmdbService.getTrending(
          mediaType: 'movie',
          timeWindow: 'week',
        );
        final results = response['results'] as List;
        return results
            .map((json) => MovieEntity.fromJson(json as Map<String, dynamic>))
            .toList();
      case ContentCategory.popular:
        final results = await _tmdbService.getPopularMovies(page: page);
        return results.map((json) => MovieEntity.fromJson(json)).toList();
      case ContentCategory.topRated:
        final results = await _tmdbService.getTopRatedMovies(page: page);
        return results.map((json) => MovieEntity.fromJson(json)).toList();
      case ContentCategory.upcoming:
        final results = await _tmdbService.getUpcomingMovies(page: page);
        return results.map((json) => MovieEntity.fromJson(json)).toList();
      case ContentCategory.nowPlaying:
        final results = await _tmdbService.getNowPlayingMovies(page: page);
        return results.map((json) => MovieEntity.fromJson(json)).toList();
      default:
        final response = await _tmdbService.getTrending(
          mediaType: 'movie',
          timeWindow: 'week',
        );
        final results = response['results'] as List;
        return results
            .map((json) => MovieEntity.fromJson(json as Map<String, dynamic>))
            .toList();
    }
  }

  Future<List<TVShowEntity>> _fetchTVShows(int page) async {
    Map<String, dynamic> response;

    switch (_category!) {
      case ContentCategory.trending:
        response = await _tmdbService.getTrending(
          mediaType: 'tv',
          timeWindow: 'week',
        );
        break;
      case ContentCategory.popular:
        response = await _tmdbService.getPopularTV(page: page);
        break;
      default:
        response = await _tmdbService.getPopularTV(page: page);
    }

    final results = response['results'] as List;
    return results
        .map((json) => TVShowEntity.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<PersonEntity>> _fetchPeople(int page) async {
    final response = await _tmdbService.getPopularPeople(page: page);
    final results = response['results'] as List;
    return results
        .map((json) => PersonEntity.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

final seeAllProvider =
    StateNotifierProvider.autoDispose<SeeAllNotifier, SeeAllState>(
      (ref) => SeeAllNotifier(TmdbService()),
    );
