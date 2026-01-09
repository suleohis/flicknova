import 'common_detail_entities.dart';

class CreatorEntity {
  final int id;
  final String creditId;
  final String name;
  final String originalName;
  final int gender;
  final String? profilePath;

  CreatorEntity({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    this.profilePath,
  });

  factory CreatorEntity.fromJson(Map<String, dynamic> json) {
    return CreatorEntity(
      id: json['id'] as int,
      creditId: json['credit_id'] as String,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      gender: json['gender'] as int? ?? 0,
      profilePath: json['profile_path'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'credit_id': creditId,
      'name': name,
      'original_name': originalName,
      'gender': gender,
      'profile_path': profilePath,
    };
  }
}

class NetworkEntity {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  NetworkEntity({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory NetworkEntity.fromJson(Map<String, dynamic> json) {
    return NetworkEntity(
      id: json['id'] as int,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String,
      originCountry: json['origin_country'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }
}

class SeasonSummaryEntity {
  final String? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  SeasonSummaryEntity({
    this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory SeasonSummaryEntity.fromJson(Map<String, dynamic> json) {
    return SeasonSummaryEntity(
      airDate: json['air_date'] as String?,
      episodeCount: json['episode_count'] as int? ?? 0,
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      seasonNumber: json['season_number'] as int,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'air_date': airDate,
      'episode_count': episodeCount,
      'id': id,
      'name': name,
      'overview': overview,
      'poster_path': posterPath,
      'season_number': seasonNumber,
      'vote_average': voteAverage,
    };
  }
}

class LastEpisodeToAirEntity {
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final String? airDate;
  final int episodeNumber;
  final String episodeType;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;

  LastEpisodeToAirEntity({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    this.runtime,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
  });

  factory LastEpisodeToAirEntity.fromJson(Map<String, dynamic> json) {
    return LastEpisodeToAirEntity(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      airDate: json['air_date'] as String?,
      episodeNumber: json['episode_number'] as int,
      episodeType: json['episode_type'] as String? ?? '',
      productionCode: json['production_code'] as String? ?? '',
      runtime: json['runtime'] as int?,
      seasonNumber: json['season_number'] as int,
      showId: json['show_id'] as int,
      stillPath: json['still_path'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'air_date': airDate,
      'episode_number': episodeNumber,
      'episode_type': episodeType,
      'production_code': productionCode,
      'runtime': runtime,
      'season_number': seasonNumber,
      'show_id': showId,
      'still_path': stillPath,
    };
  }
}

class TVSeriesDetailEntity {
  final bool adult;
  final String? backdropPath;
  final List<CreatorEntity> createdBy;
  final List<int> episodeRunTime;
  final String? firstAirDate;
  final List<GenreEntity> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String? lastAirDate;
  final LastEpisodeToAirEntity? lastEpisodeToAir;
  final String name;
  final dynamic nextEpisodeToAir; // Can be null or object
  final List<NetworkEntity> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompanyEntity> productionCompanies;
  final List<ProductionCountryEntity> productionCountries;
  final List<SeasonSummaryEntity> seasons;
  final List<SpokenLanguageEntity> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;
  final CreditsEntity? credits;
  final VideosEntity? videos;
  final ImagesEntity? images;

  TVSeriesDetailEntity({
    required this.adult,
    this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    required this.name,
    this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
    this.credits,
    this.videos,
    this.images,
  });

  factory TVSeriesDetailEntity.fromJson(Map<String, dynamic> json) {
    return TVSeriesDetailEntity(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      createdBy:
          (json['created_by'] as List?)
              ?.map((e) => CreatorEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      episodeRunTime: (json['episode_run_time'] as List?)?.cast<int>() ?? [],
      firstAirDate: json['first_air_date'] as String?,
      genres:
          (json['genres'] as List?)
              ?.map((e) => GenreEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      homepage: json['homepage'] as String? ?? '',
      id: json['id'] as int,
      inProduction: json['in_production'] as bool? ?? false,
      languages: (json['languages'] as List?)?.cast<String>() ?? [],
      lastAirDate: json['last_air_date'] as String?,
      lastEpisodeToAir: json['last_episode_to_air'] != null
          ? LastEpisodeToAirEntity.fromJson(
              json['last_episode_to_air'] as Map<String, dynamic>,
            )
          : null,
      name: json['name'] as String? ?? '',
      nextEpisodeToAir: json['next_episode_to_air'],
      networks:
          (json['networks'] as List?)
              ?.map((e) => NetworkEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      numberOfEpisodes: json['number_of_episodes'] as int? ?? 0,
      numberOfSeasons: json['number_of_seasons'] as int? ?? 0,
      originCountry: (json['origin_country'] as List?)?.cast<String>() ?? [],
      originalLanguage: json['original_language'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] as String?,
      productionCompanies:
          (json['production_companies'] as List?)
              ?.map(
                (e) =>
                    ProductionCompanyEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      productionCountries:
          (json['production_countries'] as List?)
              ?.map(
                (e) =>
                    ProductionCountryEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      seasons:
          (json['seasons'] as List?)
              ?.map(
                (e) => SeasonSummaryEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      spokenLanguages:
          (json['spoken_languages'] as List?)
              ?.map(
                (e) => SpokenLanguageEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      status: json['status'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      type: json['type'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      credits: json['credits'] != null
          ? CreditsEntity.fromJson(json['credits'] as Map<String, dynamic>)
          : null,
      videos: json['videos'] != null
          ? VideosEntity.fromJson(json['videos'] as Map<String, dynamic>)
          : null,
      images: json['images'] != null
          ? ImagesEntity.fromJson(json['images'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'created_by': createdBy.map((e) => e.toJson()).toList(),
      'episode_run_time': episodeRunTime,
      'first_air_date': firstAirDate,
      'genres': genres.map((e) => e.toJson()).toList(),
      'homepage': homepage,
      'id': id,
      'in_production': inProduction,
      'languages': languages,
      'last_air_date': lastAirDate,
      'last_episode_to_air': lastEpisodeToAir?.toJson(),
      'name': name,
      'next_episode_to_air': nextEpisodeToAir,
      'networks': networks.map((e) => e.toJson()).toList(),
      'number_of_episodes': numberOfEpisodes,
      'number_of_seasons': numberOfSeasons,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies': productionCompanies
          .map((e) => e.toJson())
          .toList(),
      'production_countries': productionCountries
          .map((e) => e.toJson())
          .toList(),
      'seasons': seasons.map((e) => e.toJson()).toList(),
      'spoken_languages': spokenLanguages.map((e) => e.toJson()).toList(),
      'status': status,
      'tagline': tagline,
      'type': type,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'credits': credits?.toJson(),
      'videos': videos?.toJson(),
      'images': images?.toJson(),
    };
  }
}
