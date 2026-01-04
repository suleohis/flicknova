import 'package:flicknova/core/models/tv_series_detail_entity.dart';
import 'package:flicknova/core/network/tmdb_service.dart';
import 'package:flicknova/features/watchlist/data/watchlist_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TVDetailState {
  final TVSeriesDetailEntity? series;
  final bool isInWatchlist;
  final bool isTogglingWatchlist;
  final bool isLoading;
  final String? error;

  TVDetailState({
    this.series,
    this.isInWatchlist = false,
    this.isTogglingWatchlist = false,
    this.isLoading = false,
    this.error,
  });

  TVDetailState copyWith({
    TVSeriesDetailEntity? series,
    bool? isInWatchlist,
    bool? isTogglingWatchlist,
    bool? isLoading,
    String? error,
  }) {
    return TVDetailState(
      series: series ?? this.series,
      isInWatchlist: isInWatchlist ?? this.isInWatchlist,
      isTogglingWatchlist: isTogglingWatchlist ?? this.isTogglingWatchlist,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class TVDetailNotifier extends Notifier<TVDetailState> {
  late final TmdbService _tmdbService;
  late final WatchlistService _watchlistService;

  @override
  TVDetailState build() {
    _tmdbService = TmdbService();
    _watchlistService = WatchlistService();
    return TVDetailState();
  }

  Future<void> loadTVSeriesDetail(int seriesId) async {
    state = state.copyWith(isLoading: true);

    try {
      final results = await Future.wait([
        _tmdbService.getTVSeriesDetails(seriesId),
        _watchlistService.isTVShowInWatchlist(seriesId),
      ]);

      final seriesData = results[0] as Map<String, dynamic>;
      final series = TVSeriesDetailEntity.fromJson(seriesData);
      final isInWatchlist = results[1] as bool;

      state = state.copyWith(
        series: series,
        isInWatchlist: isInWatchlist,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Error loading TV series detail: $e');
      }
    }
  }

  Future<void> toggleWatchlist() async {
    if (state.series == null) return;

    state = state.copyWith(isTogglingWatchlist: true);

    try {
      if (state.isInWatchlist) {
        await _watchlistService.removeTVShowFromWatchlist(state.series!.id);
        state = state.copyWith(
          isInWatchlist: false,
          isTogglingWatchlist: false,
        );
      } else {
        await _watchlistService.addTVShowToWatchlist(
          seriesId: state.series!.id,
          seriesTitle: state.series!.name,
          posterPath: state.series!.posterPath,
        );
        state = state.copyWith(isInWatchlist: true, isTogglingWatchlist: false);
      }
    } catch (e) {
      state = state.copyWith(isTogglingWatchlist: false);
      if (kDebugMode) {
        print('Error toggling watchlist: $e');
      }
    }
  }
}

final tvDetailProvider = NotifierProvider<TVDetailNotifier, TVDetailState>(
  TVDetailNotifier.new,
);
