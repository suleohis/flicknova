class TVShowEntity {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String name;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final String? posterPath;
  final String mediaType; // Always "tv"
  final List<int> genreIds;
  final double popularity;
  final String? firstAirDate;
  final double voteAverage;
  final int voteCount;
  final List<String> originCountry;

  TVShowEntity({
    required this.adult,
    this.backdropPath,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
  });

  factory TVShowEntity.fromJson(Map<String, dynamic> json) {
    return TVShowEntity(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int,
      name: json['name'] as String,
      originalLanguage: json['original_language'] as String,
      originalName: json['original_name'] as String,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      mediaType: json['media_type'] as String? ?? 'tv',
      genreIds: (json['genre_ids'] as List?)?.cast<int>() ?? [],
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      firstAirDate: json['first_air_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      originCountry: (json['origin_country'] as List?)?.cast<String>() ?? [],
    );
  }
}
