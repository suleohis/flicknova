import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/profile_stats_repository_impl.dart';
import '../../domain/entities/user_stats_entity.dart';
import '../../domain/repositories/profile_stats_repository.dart';

class ProfileStatsState {
  final UserStatsEntity? stats;
  final bool isLoading;
  final String? error;

  ProfileStatsState({this.stats, this.isLoading = false, this.error});

  ProfileStatsState copyWith({
    UserStatsEntity? stats,
    bool? isLoading,
    String? error,
  }) {
    return ProfileStatsState(
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ProfileStatsNotifier extends Notifier<ProfileStatsState> {
  late final ProfileStatsRepository _repository;

  @override
  ProfileStatsState build() {
    _repository = ProfileStatsRepositoryImpl();
    loadStats();
    return ProfileStatsState();
  }

  Future<void> loadStats() async {
    state = state.copyWith(isLoading: true);

    try {
      final stats = await _repository.getUserStats();
      state = ProfileStatsState(stats: stats, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Load profile stats error: $e');
      }
    }
  }

  Future<void> refresh() async {
    await loadStats();
  }
}

final profileStatsProvider =
    NotifierProvider<ProfileStatsNotifier, ProfileStatsState>(
      ProfileStatsNotifier.new,
    );
