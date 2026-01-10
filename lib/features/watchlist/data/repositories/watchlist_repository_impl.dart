import 'package:supabase_flutter/supabase_flutter.dart';

import '../watchlist_service.dart';
import '../../domain/entities/watchlist_item_entity.dart';
import '../../domain/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistService _service = WatchlistService();
  final SupabaseClient _client = Supabase.instance.client;

  String? get _userId => _client.auth.currentUser?.id;

  @override
  Future<List<WatchlistItemEntity>> getWatchlist() async {
    return await _service.getWatchlist();
  }

  @override
  Future<void> addToWatchlist(WatchlistItemEntity item) async {
    if (_userId == null) {
      throw Exception('User not authenticated');
    }

    // Ensure user ID is set
    final itemWithUserId = item.copyWith(userId: _userId);
    await _service.addToWatchlist(itemWithUserId);
  }

  @override
  Future<void> removeFromWatchlist(int itemId) async {
    // This method signature is from the old interface
    // For backward compatibility, we assume it's a movie
    // The updated methods should use media type explicitly
    await _service.removeFromWatchlist(tmdbId: itemId, mediaType: 'movie');
  }

  @override
  Future<bool> isInWatchlist(int itemId) async {
    // Check both movie and TV (for backward compatibility)
    final isMovie = await _service.isInWatchlist(
      tmdbId: itemId,
      mediaType: 'movie',
    );
    if (isMovie) return true;

    return await _service.isInWatchlist(tmdbId: itemId, mediaType: 'tv');
  }

  @override
  Future<void> clearWatchlist() async {
    await _service.clearWatchlist();
  }

  // New methods with explicit media type
  Future<void> removeFromWatchlistWithType({
    required int tmdbId,
    required String mediaType,
  }) async {
    await _service.removeFromWatchlist(tmdbId: tmdbId, mediaType: mediaType);
  }

  Future<bool> isInWatchlistWithType({
    required int tmdbId,
    required String mediaType,
  }) async {
    return await _service.isInWatchlist(tmdbId: tmdbId, mediaType: mediaType);
  }

  Future<List<WatchlistItemEntity>> getWatchlistByType(String mediaType) async {
    return await _service.getWatchlist(mediaType: mediaType);
  }

  Future<void> updateTVProgress({
    required int tmdbId,
    String? episodeProgress,
    int? episodesWatched,
  }) async {
    await _service.updateTVProgress(
      tmdbId: tmdbId,
      episodeProgress: episodeProgress,
      episodesWatched: episodesWatched,
    );
  }
}
