class MovieCreditsShowEntity {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String title;
  final double voteAverage;
  final int voteCount;
  final String character;
  final String creditId;
  final int order;

  MovieCreditsShowEntity({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory MovieCreditsShowEntity.fromJson(Map<String, dynamic> json) {
    return MovieCreditsShowEntity(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List?)?.cast<int>() ?? [],
      id: json['id'] as int,
      originCountry: (json['origin_country'] as List?)?.cast<String>() ?? [],
      originalLanguage: json['original_language'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      title: json['title'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      character: json['character'] as String? ?? '',
      creditId: json['credit_id'] as String,
      order: json['order'] as int? ?? 0,
    );
  }
}

class TVCreditsShowEntity {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;
  final String character;
  final String creditId;
  final int episodeCount;
  final String? firstCreditAirDate;

  TVCreditsShowEntity({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.character,
    required this.creditId,
    required this.episodeCount,
    this.firstCreditAirDate,
  });

  factory TVCreditsShowEntity.fromJson(Map<String, dynamic> json) {
    return TVCreditsShowEntity(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List?)?.cast<int>() ?? [],
      id: json['id'] as int,
      originCountry: (json['origin_country'] as List?)?.cast<String>() ?? [],
      originalLanguage: json['original_language'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      name: json['name'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      character: json['character'] as String? ?? '',
      creditId: json['credit_id'] as String,
      episodeCount: json['episode_count'] as int? ?? 0,
      firstCreditAirDate: json['first_credit_air_date'] as String?,
    );
  }
}

class PersonCombinedCreditsEntity {
  final List<TVCreditsShowEntity> tvCast;
  final List<MovieCreditsShowEntity> movieCast;
  final List<Map<String, dynamic>> crew; // Can be complex, keeping as Map

  PersonCombinedCreditsEntity({required this.tvCast, required this.movieCast, required this.crew});

  factory PersonCombinedCreditsEntity.fromJson(Map<String, dynamic> json) {
    return PersonCombinedCreditsEntity(
      tvCast:
          (json['cast'] as List?)
              ?.where((e) => e['media_type'] == 'tv').map(
                (e) => TVCreditsShowEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      movieCast:
          (json['cast'] as List?)
              ?.where((e) => e['media_type'] == 'movie').map(
                (e) => MovieCreditsShowEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      crew: (json['crew'] as List?)?.cast<Map<String, dynamic>>() ?? [],
    );
  }
}

class PersonDetailEntity {
  final bool adult;
  final List<String> alsoKnownAs;
  final String biography;
  final String? birthday;
  final String? deathday;
  final int gender; // 0 = not set, 1 = female, 2 = male
  final String? homepage;
  final int id;
  final String? imdbId;
  final String knownForDepartment;
  final String name;
  final String? placeOfBirth;
  final double popularity;
  final String? profilePath;
  final PersonCombinedCreditsEntity? combinedCredits;

  PersonDetailEntity({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    this.birthday,
    this.deathday,
    required this.gender,
    this.homepage,
    required this.id,
    this.imdbId,
    required this.knownForDepartment,
    required this.name,
    this.placeOfBirth,
    required this.popularity,
    this.profilePath,
    this.combinedCredits,
  });

  factory PersonDetailEntity.fromJson(Map<String, dynamic> json) {
    return PersonDetailEntity(
      adult: json['adult'] as bool? ?? false,
      alsoKnownAs: (json['also_known_as'] as List?)?.cast<String>() ?? [],
      biography: json['biography'] as String? ?? '',
      birthday: json['birthday'] as String?,
      deathday: json['deathday'] as String?,
      gender: json['gender'] as int? ?? 0,
      homepage: json['homepage'] as String?,
      id: json['id'] as int,
      imdbId: json['imdb_id'] as String?,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String? ?? '',
      placeOfBirth: json['place_of_birth'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      combinedCredits: json['combined_credits'] != null
          ? PersonCombinedCreditsEntity.fromJson(
              json['combined_credits'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}
