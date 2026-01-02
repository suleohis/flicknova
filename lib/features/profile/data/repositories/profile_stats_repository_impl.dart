import '../../../watchlist/data/repositories/watchlist_repository_impl.dart';
import '../../../watchlist/domain/repositories/watchlist_repository.dart';
import '../../domain/entities/user_stats_entity.dart';
import '../../domain/repositories/profile_stats_repository.dart';

class ProfileStatsRepositoryImpl implements ProfileStatsRepository {
  final WatchlistRepository _watchlistRepository;

  ProfileStatsRepositoryImpl()
    : _watchlistRepository = WatchlistRepositoryImpl();

  @override
  Future<UserStatsEntity> getUserStats() async {
    try {
      final watchlist = await _watchlistRepository.getWatchlist();

      // Calculate movies watched
      final moviesWatched = watchlist.length;

      // Calculate total hours
      final totalMinutes = watchlist.fold<int>(
        0,
        (sum, item) => sum + (item.runtime ?? 120),
      );
      final totalHours = totalMinutes ~/ 60;

      // Calculate average rating (placeholder - will be real ratings later)
      final avgRating = 8.7;

      // Calculate genre distribution
      final genreDistribution = _calculateGenreDistribution(watchlist);

      return UserStatsEntity(
        moviesWatched: moviesWatched,
        totalHours: totalHours,
        avgRating: avgRating,
        genreDistribution: genreDistribution,
      );
    } catch (e) {
      // Return empty stats on error
      return UserStatsEntity(
        moviesWatched: 0,
        totalHours: 0,
        avgRating: 0.0,
        genreDistribution: {},
      );
    }
  }

  Map<String, double> _calculateGenreDistribution(List watchlist) {
    if (watchlist.isEmpty) {
      return {};
    }

    // Mock genre distribution for now
    // In real app, this would calculate from actual movie genres
    return {'Sci-Fi': 34.0, 'Drama': 28.0, 'Action': 20.0, 'Other': 18.0};
  }
}
