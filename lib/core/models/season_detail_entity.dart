import 'common_detail_entities.dart';

class EpisodeDetailEntity {
  final String? airDate;
  final int episodeNumber;
  final String episodeType;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;
  final List<CrewMemberEntity> crew;
  final List<CastMemberEntity> guestStars;

  EpisodeDetailEntity({
    this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    this.runtime,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
    required this.voteAverage,
    required this.voteCount,
    required this.crew,
    required this.guestStars,
  });

  factory EpisodeDetailEntity.fromJson(Map<String, dynamic> json) {
    return EpisodeDetailEntity(
      airDate: json['air_date'] as String?,
      episodeNumber: json['episode_number'] as int,
      episodeType: json['episode_type'] as String? ?? 'standard',
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      productionCode: json['production_code'] as String? ?? '',
      runtime: json['runtime'] as int?,
      seasonNumber: json['season_number'] as int,
      showId: json['show_id'] as int,
      stillPath: json['still_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      crew:
          (json['crew'] as List?)
              ?.map((e) => CrewMemberEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      guestStars:
          (json['guest_stars'] as List?)
              ?.map((e) => CastMemberEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class SeasonDetailEntity {
  final String id;
  final String? airDate;
  final List<EpisodeDetailEntity> episodes;
  final String name;
  final String overview;
  final int seasonDetailId;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  SeasonDetailEntity({
    required this.id,
    this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonDetailId,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory SeasonDetailEntity.fromJson(Map<String, dynamic> json) {
    return SeasonDetailEntity(
      id: json['_id'] as String,
      airDate: json['air_date'] as String?,
      episodes:
          (json['episodes'] as List?)
              ?.map(
                (e) => EpisodeDetailEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      seasonDetailId: json['id'] as int? ?? 0,
      posterPath: json['poster_path'] as String?,
      seasonNumber: json['season_number'] as int? ?? 0,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
