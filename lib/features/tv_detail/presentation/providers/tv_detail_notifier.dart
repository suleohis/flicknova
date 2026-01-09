import 'package:flicknova/core/models/tv_series_detail_entity.dart';
import 'package:flicknova/core/network/tmdb_service.dart';
import 'package:flicknova/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flicknova/features/watchlist/data/watchlist_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      final isInWatchlist = ref.read(authProvider).profile?.watchList?.contains(
        series.toJson(),
      ) ??
          false;

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

  Future<void> toggleWatchlist(BuildContext context) async {
    if (state.series == null) return;

    state = state.copyWith(isTogglingWatchlist: true);

    try {

        final isInWatchlist = await ref
            .read(authProvider.notifier)
            .addWatchList(state.series!.toJson());
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

final tvDetailProvider = NotifierProvider<TVDetailNotifier, TVDetailState>(
  TVDetailNotifier.new,
);
