import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/domain/entities/movie_entity.dart';
import '../../data/repositories/watchlist_repository_impl.dart';
import '../../domain/entities/watchlist_item_entity.dart';
import '../../domain/repositories/watchlist_repository.dart';

class WatchlistState {
  final List<WatchlistItemEntity> items;
  final bool isGridView;
  final bool isLoading;
  final String? error;

  WatchlistState({
    this.items = const [],
    this.isGridView = true,
    this.isLoading = false,
    this.error,
  });

  int get totalHoursSaved {
    return items.fold(0, (sum, item) {
      final runtime = item.runtime ?? 120; // default 2 hours
      return sum + (runtime ~/ 60);
    });
  }

  WatchlistState copyWith({
    List<WatchlistItemEntity>? items,
    bool? isGridView,
    bool? isLoading,
    String? error,
  }) {
    return WatchlistState(
      items: items ?? this.items,
      isGridView: isGridView ?? this.isGridView,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class WatchlistNotifier extends Notifier<WatchlistState> {
  late final WatchlistRepository _repository;

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

  Future<void> addItem(MovieEntity movie, {int? runtime}) async {
    final item = WatchlistItemEntity.fromMovie(movie, runtime: runtime);

    try {
      await _repository.addToWatchlist(item);
      await loadWatchlist();
    } catch (e) {
      if (kDebugMode) {
        print('Add to watchlist error: $e');
      }
    }
  }

  Future<void> removeItem(int movieId) async {
    try {
      await _repository.removeFromWatchlist(movieId);
      await loadWatchlist();
    } catch (e) {
      if (kDebugMode) {
        print('Remove from watchlist error: $e');
      }
    }
  }

  Future<bool> isInWatchlist(int movieId) async {
    return await _repository.isInWatchlist(movieId);
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
