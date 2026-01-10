import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/tv_show_entity.dart';

class WatchlistItemEntity {
  final String? id; // Supabase UUID (null for new items)
  final String userId;
  final int tmdbId; // Renamed from 'id' to be clearer
  final String mediaType; // 'movie' or 'tv'
  final String title;
  final String? posterPath;
  final DateTime addedAt;
  final DateTime? updatedAt;
  final int? runtime; // in minutes (for movies)
  final String? episodeProgress; // e.g., "S1:E4" (for TV shows)
  final int? episodesWatched;
  final int? totalEpisodes;

  WatchlistItemEntity({
    this.id,
    required this.userId,
    required this.tmdbId,
    required this.mediaType,
    required this.title,
    this.posterPath,
    required this.addedAt,
    this.updatedAt,
    this.runtime,
    this.episodeProgress,
    this.episodesWatched,
    this.totalEpisodes,
  });

  // Convert to JSON for Supabase (snake_case)
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'tmdb_id': tmdbId,
      'media_type': mediaType,
      'title': title,
      'poster_path': posterPath,
      'added_at': addedAt.toIso8601String(),
      'updated_at': (updatedAt ?? DateTime.now()).toIso8601String(),
      'runtime': runtime,
      'episode_progress': episodeProgress,
      'episodes_watched': episodesWatched,
      'total_episodes': totalEpisodes,
    };
  }

  // Create from Supabase response (snake_case)
  factory WatchlistItemEntity.fromSupabase(Map<String, dynamic> json) {
    return WatchlistItemEntity(
      id: json['id'] as String?,
      userId: json['user_id'] as String,
      tmdbId: json['tmdb_id'] as int,
      mediaType: json['media_type'] as String,
      title: json['title'] as String,
      posterPath: json['poster_path'] as String?,
      addedAt: DateTime.parse(json['added_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      runtime: json['runtime'] as int?,
      episodeProgress: json['episode_progress'] as String?,
      episodesWatched: json['episodes_watched'] as int?,
      totalEpisodes: json['total_episodes'] as int?,
    );
  }

  // Create from MovieEntity
  factory WatchlistItemEntity.fromMovie(
    MovieEntity movie, {
    required String userId,
    int? runtime,
  }) {
    return WatchlistItemEntity(
      userId: userId,
      tmdbId: movie.id,
      mediaType: 'movie',
      title: movie.title,
      posterPath: movie.posterPath,
      addedAt: DateTime.now(),
      runtime: runtime ?? 120, // default 2 hours
    );
  }

  // Create from TVShowEntity
  factory WatchlistItemEntity.fromTVShow(
    TVShowEntity tvShow, {
    required String userId,
    int? totalEpisodes,
  }) {
    return WatchlistItemEntity(
      userId: userId,
      tmdbId: tvShow.id,
      mediaType: 'tv',
      title: tvShow.name,
      posterPath: tvShow.posterPath,
      addedAt: DateTime.now(),
      totalEpisodes: totalEpisodes,
      episodesWatched: 0,
    );
  }

  // Helper getters
  bool get isMovie => mediaType == 'movie';
  bool get isTVShow => mediaType == 'tv';

  // Copy with method for updates
  WatchlistItemEntity copyWith({
    String? id,
    String? userId,
    int? tmdbId,
    String? mediaType,
    String? title,
    String? posterPath,
    DateTime? addedAt,
    DateTime? updatedAt,
    int? runtime,
    String? episodeProgress,
    int? episodesWatched,
    int? totalEpisodes,
  }) {
    return WatchlistItemEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tmdbId: tmdbId ?? this.tmdbId,
      mediaType: mediaType ?? this.mediaType,
      title: title ?? this.title,
      posterPath: posterPath ?? this.posterPath,
      addedAt: addedAt ?? this.addedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      runtime: runtime ?? this.runtime,
      episodeProgress: episodeProgress ?? this.episodeProgress,
      episodesWatched: episodesWatched ?? this.episodesWatched,
      totalEpisodes: totalEpisodes ?? this.totalEpisodes,
    );
  }
}
