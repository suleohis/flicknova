import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/domain/entities/movie_entity.dart';

// Simple provider to track recently viewed movies
class RecentlyViewedNotifier extends Notifier<List<MovieEntity>> {
  @override
  List<MovieEntity> build() {
    return [];
  }

  void addMovie(MovieEntity movie) {
    final current = [...state];

    // Remove if already exists
    current.removeWhere((m) => m.id == movie.id);

    // Add to beginning
    current.insert(0, movie);

    // Keep only last 10
    if (current.length > 10) {
      current.removeLast();
    }

    state = current;
  }

  void clear() {
    state = [];
  }
}

final recentlyViewedProvider =
    NotifierProvider<RecentlyViewedNotifier, List<MovieEntity>>(
      RecentlyViewedNotifier.new,
    );
