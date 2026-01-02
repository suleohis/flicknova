import '../entities/watchlist_item_entity.dart';

abstract class WatchlistRepository {
  Future<List<WatchlistItemEntity>> getWatchlist();
  Future<void> addToWatchlist(WatchlistItemEntity item);
  Future<void> removeFromWatchlist(int itemId);
  Future<bool> isInWatchlist(int itemId);
  Future<void> clearWatchlist();
}
