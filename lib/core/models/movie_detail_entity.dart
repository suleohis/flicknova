import 'common_detail_entities.dart';

class MovieDetailEntity {
  final bool adult;
  final String? backdropPath;
  final dynamic belongsToCollection; // Can be null or object
  final int budget;
  final List<GenreEntity> genres;
  final String homepage;
  final int id;
  final String? imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompanyEntity> productionCompanies;
  final List<ProductionCountryEntity> productionCountries;
  final String? releaseDate;
  final int revenue;
  final int? runtime;
  final List<SpokenLanguageEntity> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final CreditsEntity? credits;
  final VideosEntity? videos;
  final ImagesEntity? images;
  final RecommendationsEntity? recommendations;

  MovieDetailEntity({
    required this.adult,
    this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    this.releaseDate,
    required this.revenue,
    this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.credits,
    this.videos,
    this.images,
    this.recommendations,
  });

  factory MovieDetailEntity.fromJson(Map<String, dynamic> json) {
    return MovieDetailEntity(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      belongsToCollection: json['belongs_to_collection'],
      budget: json['budget'] as int? ?? 0,
      genres:
          (json['genres'] as List?)
              ?.map((e) => GenreEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      homepage: json['homepage'] as String? ?? '',
      id: json['id'] as int,
      imdbId: json['imdb_id'] as String?,
      originCountry: (json['origin_country'] as List?)?.cast<String>() ?? [],
      originalLanguage: json['original_language'] as String? ?? '',
      originalTitle: json['original_title'] as String? ?? '',
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
      releaseDate: json['release_date'] as String?,
      revenue: json['revenue'] as int? ?? 0,
      runtime: json['runtime'] as int?,
      spokenLanguages:
          (json['spoken_languages'] as List?)
              ?.map(
                (e) => SpokenLanguageEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      status: json['status'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      title: json['title'] as String? ?? '',
      video: json['video'] as bool? ?? false,
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
      recommendations: json['recommendations'] != null
          ? RecommendationsEntity.fromJson(
              json['recommendations'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}
