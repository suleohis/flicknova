import 'package:supabase_flutter/supabase_flutter.dart';

class WatchlistService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Add a movie to the user's watchlist
  Future<void> addToWatchlist({
    required int movieId,
    required String movieTitle,
    String? posterPath,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    await _client.from('watchlist').insert({
      'user_id': userId,
      'movie_id': movieId,
      'movie_title': movieTitle,
      'poster_path': posterPath,
    });
  }

  /// Remove a movie from the user's watchlist
  Future<void> removeFromWatchlist(int movieId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    await _client.from('watchlist').delete().match({
      'user_id': userId,
      'movie_id': movieId,
    });
  }

  /// Check if a movie is in the user's watchlist
  Future<bool> isInWatchlist(int movieId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return false;

    try {
      final response = await _client
          .from('watchlist')
          .select()
          .eq('user_id', userId)
          .eq('movie_id', movieId)
          .maybeSingle();

      return response != null;
    } catch (e) {
      return false;
    }
  }

  /// Get all movies in the user's watchlist
  Future<List<Map<String, dynamic>>> getWatchlist() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final response = await _client
        .from('watchlist')
        .select()
        .eq('user_id', userId)
        .order('added_at', ascending: false);

    return List<Map<String, dynamic>>.from(response as List);
  }

  /// Add a TV show to the user's watchlist
  Future<void> addTVShowToWatchlist({
    required int seriesId,
    required String seriesTitle,
    String? posterPath,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    await _client.from('watchlist').insert({
      'user_id': userId,
      'series_id': seriesId,
      'series_title': seriesTitle,
      'poster_path': posterPath,
      'media_type': 'tv',
    });
  }

  /// Remove a TV show from the user's watchlist
  Future<void> removeTVShowFromWatchlist(int seriesId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    await _client.from('watchlist').delete().match({
      'user_id': userId,
      'series_id': seriesId,
    });
  }

  /// Check if a TV show is in the user's watchlist
  Future<bool> isTVShowInWatchlist(int seriesId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return false;

    try {
      final response = await _client
          .from('watchlist')
          .select()
          .eq('user_id', userId)
          .eq('series_id', seriesId)
          .maybeSingle();

      return response != null;
    } catch (e) {
      return false;
    }
  }
}
