class MovieEntity {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String title;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String? posterPath;
  final String mediaType; // Always "movie"
  final List<int> genreIds;
  final double popularity;
  final String? releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieEntity({
    required this.adult,
    this.backdropPath,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    return MovieEntity(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int,
      title: json['title'] as String,
      originalLanguage: json['original_language'] as String,
      originalTitle: json['original_title'] as String,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      mediaType: json['media_type'] as String? ?? 'movie',
      genreIds: (json['genre_ids'] as List?)?.cast<int>() ?? [],
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] as String?,
      video: json['video'] as bool? ?? false,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }
}
