import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/entities/watchlist_item_entity.dart';

class WatchlistService {
  final SupabaseClient _client = Supabase.instance.client;

  String? get _userId => _client.auth.currentUser?.id;

  /// Add an item (movie or TV show) to the user's watchlist
  Future<void> addToWatchlist(WatchlistItemEntity item) async {
    if (_userId == null) {
      throw Exception('User not authenticated');
    }

    await _client.from('watchlist').upsert(item.toJson());
  }

  /// Remove an item from the user's watchlist
  Future<void> removeFromWatchlist({
    required int tmdbId,
    required String mediaType,
  }) async {
    if (_userId == null) {
      throw Exception('User not authenticated');
    }

    await _client.from('watchlist').delete().match({
      'user_id': _userId!,
      'tmdb_id': tmdbId,
      'media_type': mediaType,
    });
  }

  /// Check if an item is in the user's watchlist
  Future<bool> isInWatchlist({
    required int tmdbId,
    required String mediaType,
  }) async {
    if (_userId == null) return false;

    try {
      final response = await _client
          .from('watchlist')
          .select()
          .eq('user_id', _userId!)
          .eq('tmdb_id', tmdbId)
          .eq('media_type', mediaType)
          .maybeSingle();

      return response != null;
    } catch (e) {
      return false;
    }
  }

  /// Get all items in the user's watchlist
  Future<List<WatchlistItemEntity>> getWatchlist({String? mediaType}) async {
    if (_userId == null) {
      throw Exception('User not authenticated');
    }

    // Build query with filter if specified
    dynamic query;
    if (mediaType != null && mediaType != 'all') {
      query = await _client
          .from('watchlist')
          .select()
          .eq('user_id', _userId!)
          .eq('media_type', mediaType)
          .order('added_at', ascending: false);
    } else {
      query = await _client
          .from('watchlist')
          .select()
          .eq('user_id', _userId!)
          .order('added_at', ascending: false);
    }

    return (query as List)
        .map((json) => WatchlistItemEntity.fromSupabase(json))
        .toList();
  }

  /// Update episode progress for a TV show
  Future<void> updateTVProgress({
    required int tmdbId,
    String? episodeProgress,
    int? episodesWatched,
  }) async {
    if (_userId == null) {
      throw Exception('User not authenticated');
    }

    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (episodeProgress != null) {
      updates['episode_progress'] = episodeProgress;
    }
    if (episodesWatched != null) {
      updates['episodes_watched'] = episodesWatched;
    }

    await _client.from('watchlist').update(updates).match({
      'user_id': _userId!,
      'tmdb_id': tmdbId,
      'media_type': 'tv',
    });
  }

  /// Clear all watchlist items
  Future<void> clearWatchlist() async {
    if (_userId == null) {
      throw Exception('User not authenticated');
    }

    await _client.from('watchlist').delete().eq('user_id', _userId!);
  }

  /// Get watchlist count by media type
  Future<Map<String, int>> getWatchlistCounts() async {
    if (_userId == null) {
      return {'movies': 0, 'tv': 0, 'total': 0};
    }

    final items = await getWatchlist();
    final movies = items.where((item) => item.mediaType == 'movie').length;
    final tvShows = items.where((item) => item.mediaType == 'tv').length;

    return {'movies': movies, 'tv': tvShows, 'total': items.length};
  }
}
