class SearchResultEntity {
  final int id;
  final String mediaType; // 'movie', 'tv', or 'person'
  final String title; // Can be movie title, TV show name, or person name
  final String? posterPath; // or profilePath for people
  final String? overview;
  final double? voteAverage;
  final String? releaseDate; // or firstAirDate for TV
  final String? knownForDepartment; // For people

  SearchResultEntity({
    required this.id,
    required this.mediaType,
    required this.title,
    this.posterPath,
    this.overview,
    this.voteAverage,
    this.releaseDate,
    this.knownForDepartment,
  });

  factory SearchResultEntity.fromJson(Map<String, dynamic> json) {
    final mediaType = json['media_type'] as String;

    return SearchResultEntity(
      id: json['id'] as int,
      mediaType: mediaType,
      title: (json['title'] ?? json['name'] ?? '') as String,
      posterPath: (json['poster_path'] ?? json['profile_path']) as String?,
      overview: json['overview'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      releaseDate: (json['release_date'] ?? json['first_air_date']) as String?,
      knownForDepartment: json['known_for_department'] as String?,
    );
  }

  // Helper getters
  bool get isMovie => mediaType == 'movie';
  bool get isTVShow => mediaType == 'tv';
  bool get isPerson => mediaType == 'person';
}
