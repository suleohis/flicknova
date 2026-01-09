import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/season_entity.dart';
import '../../data/repositories/season_repository_impl.dart';
import '../../domain/repositories/season_repository.dart';

class SeasonState {
  final SeasonEntity? season;
  final bool isLoading;
  final String? error;
  final String? showName; // Store the show name for display

  SeasonState({this.season, this.isLoading = false, this.error, this.showName});

  SeasonState copyWith({
    SeasonEntity? season,
    bool? isLoading,
    String? error,
    String? showName,
  }) {
    return SeasonState(
      season: season ?? this.season,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      showName: showName ?? this.showName,
    );
  }
}

class SeasonNotifier extends Notifier<SeasonState> {
  late final SeasonRepository _repository;

  @override
  SeasonState build() {
    _repository = SeasonRepositoryImpl();
    return SeasonState();
  }

  Future<void> loadSeasonDetails({
    required int tvId,
    required int seasonNumber,
    String? showName,
  }) async {
    state = state.copyWith(isLoading: true, error: null, showName: showName);

    try {
      final season = await _repository.getSeasonDetails(
        tvId: tvId,
        seasonNumber: seasonNumber,
      );

      state = state.copyWith(season: season, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load season details. Please try again.',
      );
      if (kDebugMode) {
        print('Error loading season details: $e');
      }
    }
  }
}

final seasonProvider = NotifierProvider<SeasonNotifier, SeasonState>(
  SeasonNotifier.new,
);
