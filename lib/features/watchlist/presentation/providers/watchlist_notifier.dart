import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/tv_show_entity.dart';
import '../../data/repositories/watchlist_repository_impl.dart';
import '../../domain/entities/watchlist_item_entity.dart';

class WatchlistState {
  final List<WatchlistItemEntity> items;
  final String selectedFilter; // 'all', 'movie', or 'tv'
  final bool isGridView;
  final bool isLoading;
  final String? error;

  WatchlistState({
    this.items = const [],
    this.selectedFilter = 'all',
    this.isGridView = true,
    this.isLoading = false,
    this.error,
  });

  List<WatchlistItemEntity> get filteredItems {
    if (selectedFilter == 'all') return items;
    return items.where((item) => item.mediaType == selectedFilter).toList();
  }

  int get totalHoursSaved {
    return items.fold(0, (sum, item) {
      if (item.isMovie) {
        final runtime = item.runtime ?? 120; // default 2 hours
        return sum + (runtime ~/ 60);
      } else {
        // For TV shows, estimate based on episodes watched
        final episodesWatched = item.episodesWatched ?? 0;
        final hoursPerEpisode = 1; // Average TV episode is ~45 mins
        return sum + episodesWatched * hoursPerEpisode;
      }
    });
  }

  int get movieCount => items.where((item) => item.isMovie).length;
  int get tvShowCount => items.where((item) => item.isTVShow).length;

  WatchlistState copyWith({
    List<WatchlistItemEntity>? items,
    String? selectedFilter,
    bool? isGridView,
    bool? isLoading,
    String? error,
  }) {
    return WatchlistState(
      items: items ?? this.items,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      isGridView: isGridView ?? this.isGridView,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class WatchlistNotifier extends Notifier<WatchlistState> {
  late final WatchlistRepositoryImpl _repository;

  @override
  WatchlistState build() {
    _repository = WatchlistRepositoryImpl();
    loadWatchlist();
    return WatchlistState();
  }

  Future<void> loadWatchlist() async {
    state = state.copyWith(isLoading: true);

    try {
      final items = await _repository.getWatchlist();
      state = state.copyWith(items: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Load watchlist error: $e');
      }
    }
  }

  Future<void> addMovie(MovieEntity movie, {int? runtime}) async {
    final item = WatchlistItemEntity.fromMovie(
      movie,
      userId: '', // Will be set in repository
      runtime: runtime,
    );

    try {
      await _repository.addToWatchlist(item);
      await loadWatchlist();
    } catch (e) {
      state = state.copyWith(error: 'Failed to add to watchlist');
      if (kDebugMode) {
        print('Add movie to watchlist error: $e');
      }
    }
  }

  Future<void> addTVShow(TVShowEntity tvShow, {int? totalEpisodes}) async {
    final item = WatchlistItemEntity.fromTVShow(
      tvShow,
      userId: '', // Will be set in repository
      totalEpisodes: totalEpisodes,
    );

    try {
      await _repository.addToWatchlist(item);
      await loadWatchlist();
    } catch (e) {
      state = state.copyWith(error: 'Failed to add to watchlist');
      if (kDebugMode) {
        print('Add TV show to watchlist error: $e');
      }
    }
  }

  Future<void> removeItem(int tmdbId, String mediaType) async {
    try {
      await _repository.removeFromWatchlistWithType(
        tmdbId: tmdbId,
        mediaType: mediaType,
      );
      await loadWatchlist();
    } catch (e) {
      state = state.copyWith(error: 'Failed to remove from watchlist');
      if (kDebugMode) {
        print('Remove from watchlist error: $e');
      }
    }
  }

  Future<bool> isMovieInWatchlist(int movieId) async {
    return await _repository.isInWatchlistWithType(
      tmdbId: movieId,
      mediaType: 'movie',
    );
  }

  Future<bool> isTVShowInWatchlist(int tvShowId) async {
    return await _repository.isInWatchlistWithType(
      tmdbId: tvShowId,
      mediaType: 'tv',
    );
  }

  Future<void> updateTVProgress({
    required int tmdbId,
    String? episodeProgress,
    int? episodesWatched,
  }) async {
    try {
      await _repository.updateTVProgress(
        tmdbId: tmdbId,
        episodeProgress: episodeProgress,
        episodesWatched: episodesWatched,
      );
      await loadWatchlist();
    } catch (e) {
      if (kDebugMode) {
        print('Update TV progress error: $e');
      }
    }
  }

  void setFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  void toggleViewMode() {
    state = state.copyWith(isGridView: !state.isGridView);
  }

  Future<void> clearAll() async {
    try {
      await _repository.clearWatchlist();
      await loadWatchlist();
    } catch (e) {
      if (kDebugMode) {
        print('Clear watchlist error: $e');
      }
    }
  }
}

final watchlistProvider = NotifierProvider<WatchlistNotifier, WatchlistState>(
  WatchlistNotifier.new,
);
