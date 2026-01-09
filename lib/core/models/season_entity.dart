class GuestStarEntity {
  final int id;
  final String name;
  final String character;
  final String? profilePath;
  final int order;
  final String? creditId;

  GuestStarEntity({
    required this.id,
    required this.name,
    required this.character,
    this.profilePath,
    required this.order,
    this.creditId,
  });

  factory GuestStarEntity.fromJson(Map<String, dynamic> json) {
    return GuestStarEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      character: json['character'] as String,
      profilePath: json['profile_path'] as String?,
      order: json['order'] as int,
      creditId: json['credit_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'character': character,
      'profile_path': profilePath,
      'order': order,
      'credit_id': creditId,
    };
  }
}

class EpisodeEntity {
  final int id;
  final String name;
  final String overview;
  final int episodeNumber;
  final int seasonNumber;
  final String? airDate;
  final int? runtime;
  final double voteAverage;
  final int voteCount;
  final String? stillPath;
  final List<GuestStarEntity> guestStars;
  final String? episodeType;

  EpisodeEntity({
    required this.id,
    required this.name,
    required this.overview,
    required this.episodeNumber,
    required this.seasonNumber,
    this.airDate,
    this.runtime,
    required this.voteAverage,
    required this.voteCount,
    this.stillPath,
    this.guestStars = const [],
    this.episodeType,
  });

  factory EpisodeEntity.fromJson(Map<String, dynamic> json) {
    return EpisodeEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String? ?? '',
      episodeNumber: json['episode_number'] as int,
      seasonNumber: json['season_number'] as int,
      airDate: json['air_date'] as String?,
      runtime: json['runtime'] as int?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      stillPath: json['still_path'] as String?,
      guestStars:
          (json['guest_stars'] as List<dynamic>?)
              ?.map((e) => GuestStarEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      episodeType: json['episode_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'episode_number': episodeNumber,
      'season_number': seasonNumber,
      'air_date': airDate,
      'runtime': runtime,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'still_path': stillPath,
      'guest_stars': guestStars.map((e) => e.toJson()).toList(),
      'episode_type': episodeType,
    };
  }
}

class SeasonEntity {
  final int id;
  final String name;
  final String overview;
  final int seasonNumber;
  final String? airDate;
  final String? posterPath;
  final List<EpisodeEntity> episodes;
  final int? episodeCount;

  SeasonEntity({
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    this.airDate,
    this.posterPath,
    this.episodes = const [],
    this.episodeCount,
  });

  factory SeasonEntity.fromJson(Map<String, dynamic> json) {
    return SeasonEntity(
      id: json['id'] as int? ?? json['_id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String? ?? '',
      seasonNumber: json['season_number'] as int,
      airDate: json['air_date'] as String?,
      posterPath: json['poster_path'] as String?,
      episodes:
          (json['episodes'] as List<dynamic>?)
              ?.map((e) => EpisodeEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      episodeCount: json['episode_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'season_number': seasonNumber,
      'air_date': airDate,
      'poster_path': posterPath,
      'episodes': episodes.map((e) => e.toJson()).toList(),
      'episode_count': episodeCount,
    };
  }
}
