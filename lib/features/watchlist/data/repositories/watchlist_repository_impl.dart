import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/watchlist_item_entity.dart';
import '../../domain/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  static const String _watchlistKey = 'watchlist';

  @override
  Future<List<WatchlistItemEntity>> getWatchlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_watchlistKey);

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded
          .map(
            (item) =>
                WatchlistItemEntity.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> addToWatchlist(WatchlistItemEntity item) async {
    final watchlist = await getWatchlist();

    // Check if already exists
    if (watchlist.any((i) => i.id == item.id)) {
      return;
    }

    // Add new item at the beginning
    watchlist.insert(0, item);

    // Save to storage
    await _saveWatchlist(watchlist);
  }

  @override
  Future<void> removeFromWatchlist(int itemId) async {
    final watchlist = await getWatchlist();

    // Remove item
    watchlist.removeWhere((item) => item.id == itemId);

    // Save to storage
    await _saveWatchlist(watchlist);
  }

  @override
  Future<bool> isInWatchlist(int itemId) async {
    final watchlist = await getWatchlist();
    return watchlist.any((item) => item.id == itemId);
  }

  @override
  Future<void> clearWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_watchlistKey);
  }

  Future<void> _saveWatchlist(List<WatchlistItemEntity> watchlist) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = watchlist.map((item) => item.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await prefs.setString(_watchlistKey, jsonString);
  }
}
