import '../../../../core/models/movie_entity.dart';

class WatchlistItemEntity {
  final int id;
  final String title;
  final String? posterPath;
  final DateTime addedAt;
  final int? runtime; // in minutes
  final String? episodeProgress; // e.g., "S1:E4"
  final int? episodesWatched;
  final int? totalEpisodes;
  final String mediaType; // 'movie' or 'tv'

  WatchlistItemEntity({
    required this.id,
    required this.title,
    this.posterPath,
    required this.addedAt,
    this.runtime,
    this.episodeProgress,
    this.episodesWatched,
    this.totalEpisodes,
    this.mediaType = 'movie',
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'addedAt': addedAt.toIso8601String(),
      'runtime': runtime,
      'episodeProgress': episodeProgress,
      'episodesWatched': episodesWatched,
      'totalEpisodes': totalEpisodes,
      'mediaType': mediaType,
    };
  }

  // Create from JSON
  factory WatchlistItemEntity.fromJson(Map<String, dynamic> json) {
    return WatchlistItemEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: json['posterPath'] as String?,
      addedAt: DateTime.parse(json['addedAt'] as String),
      runtime: json['runtime'] as int?,
      episodeProgress: json['episodeProgress'] as String?,
      episodesWatched: json['episodesWatched'] as int?,
      totalEpisodes: json['totalEpisodes'] as int?,
      mediaType: json['mediaType'] as String? ?? 'movie',
    );
  }

  // Create from MovieEntity
  factory WatchlistItemEntity.fromMovie(MovieEntity movie, {int? runtime}) {
    return WatchlistItemEntity(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      addedAt: DateTime.now(),
      runtime: runtime ?? 120, // default 2 hours
      mediaType: 'movie',
    );
  }
}
