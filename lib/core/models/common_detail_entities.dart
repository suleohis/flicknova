class GenreEntity {
  final int id;
  final String name;

  GenreEntity({required this.id, required this.name});

  factory GenreEntity.fromJson(Map<String, dynamic> json) {
    return GenreEntity(id: json['id'] as int, name: json['name'] as String);
  }
}

class ProductionCompanyEntity {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompanyEntity({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompanyEntity.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyEntity(
      id: json['id'] as int,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String,
      originCountry: json['origin_country'] as String? ?? '',
    );
  }
}

class ProductionCountryEntity {
  final String iso31661;
  final String name;

  ProductionCountryEntity({required this.iso31661, required this.name});

  factory ProductionCountryEntity.fromJson(Map<String, dynamic> json) {
    return ProductionCountryEntity(
      iso31661: json['iso_3166_1'] as String,
      name: json['name'] as String,
    );
  }
}

class SpokenLanguageEntity {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguageEntity({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguageEntity.fromJson(Map<String, dynamic> json) {
    return SpokenLanguageEntity(
      englishName: json['english_name'] as String,
      iso6391: json['iso_639_1'] as String,
      name: json['name'] as String? ?? '',
    );
  }
}

class CastMemberEntity {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int? castId;
  final String character;
  final String creditId;
  final int order;

  CastMemberEntity({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory CastMemberEntity.fromJson(Map<String, dynamic> json) {
    return CastMemberEntity(
      adult: json['adult'] as bool? ?? false,
      gender: json['gender'] as int? ?? 0,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      castId: json['cast_id'] as int?,
      character: json['character'] as String? ?? '',
      creditId: json['credit_id'] as String,
      order: json['order'] as int,
    );
  }
}

class CrewMemberEntity {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String creditId;
  final String department;
  final String job;

  CrewMemberEntity({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  factory CrewMemberEntity.fromJson(Map<String, dynamic> json) {
    return CrewMemberEntity(
      adult: json['adult'] as bool? ?? false,
      gender: json['gender'] as int? ?? 0,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      creditId: json['credit_id'] as String,
      department: json['department'] as String,
      job: json['job'] as String,
    );
  }
}

class CreditsEntity {
  final List<CastMemberEntity> cast;
  final List<CrewMemberEntity> crew;

  CreditsEntity({required this.cast, required this.crew});

  factory CreditsEntity.fromJson(Map<String, dynamic> json) {
    return CreditsEntity(
      cast:
          (json['cast'] as List?)
              ?.map((e) => CastMemberEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      crew:
          (json['crew'] as List?)
              ?.map((e) => CrewMemberEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class VideoEntity {
  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;

  VideoEntity({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory VideoEntity.fromJson(Map<String, dynamic> json) {
    return VideoEntity(
      iso6391: json['iso_639_1'] as String,
      iso31661: json['iso_3166_1'] as String,
      name: json['name'] as String,
      key: json['key'] as String,
      site: json['site'] as String,
      size: json['size'] as int,
      type: json['type'] as String,
      official: json['official'] as bool? ?? false,
      publishedAt: json['published_at'] as String,
      id: json['id'] as String,
    );
  }
}

class VideosEntity {
  final List<VideoEntity> results;

  VideosEntity({required this.results});

  factory VideosEntity.fromJson(Map<String, dynamic> json) {
    return VideosEntity(
      results:
          (json['results'] as List?)
              ?.map((e) => VideoEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class ImageEntity {
  final double aspectRatio;
  final int height;
  final String? iso31661;
  final String? iso6391;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;

  ImageEntity({
    required this.aspectRatio,
    required this.height,
    this.iso31661,
    this.iso6391,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory ImageEntity.fromJson(Map<String, dynamic> json) {
    return ImageEntity(
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      height: json['height'] as int,
      iso31661: json['iso_3166_1'] as String?,
      iso6391: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      width: json['width'] as int,
    );
  }
}

class ImagesEntity {
  final List<ImageEntity> backdrops;
  final List<ImageEntity> logos;
  final List<ImageEntity> posters;

  ImagesEntity({
    required this.backdrops,
    required this.logos,
    required this.posters,
  });

  factory ImagesEntity.fromJson(Map<String, dynamic> json) {
    return ImagesEntity(
      backdrops:
          (json['backdrops'] as List?)
              ?.map((e) => ImageEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      logos:
          (json['logos'] as List?)
              ?.map((e) => ImageEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      posters:
          (json['posters'] as List?)
              ?.map((e) => ImageEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class RecommendationEntity {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String? posterPath;
  final String mediaType;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final String? releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  RecommendationEntity({
    required this.adult,
    this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    this.posterPath,
    required this.mediaType,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory RecommendationEntity.fromJson(Map<String, dynamic> json) {
    return RecommendationEntity(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int,
      title: json['title'] as String? ?? json['name'] as String? ?? '',
      originalTitle:
          json['original_title'] as String? ??
          json['original_name'] as String? ??
          '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      mediaType: json['media_type'] as String? ?? 'movie',
      originalLanguage: json['original_language'] as String? ?? '',
      genreIds: (json['genre_ids'] as List?)?.cast<int>() ?? [],
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      releaseDate:
          json['release_date'] as String? ?? json['first_air_date'] as String?,
      video: json['video'] as bool? ?? false,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }
}

class RecommendationsEntity {
  final int page;
  final List<RecommendationEntity> results;
  final int? totalPages;
  final int? totalResults;

  RecommendationsEntity({
    required this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory RecommendationsEntity.fromJson(Map<String, dynamic> json) {
    return RecommendationsEntity(
      page: json['page'] as int? ?? 1,
      results:
          (json['results'] as List?)
              ?.map(
                (e) => RecommendationEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      totalPages: json['total_pages'] as int?,
      totalResults: json['total_results'] as int?,
    );
  }
}
