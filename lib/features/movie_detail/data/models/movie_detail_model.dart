import '../../domain/entities/movie_detail_entity.dart';
import 'genre_model.dart';

class MovieDetailModel extends MovieDetailEntity {
  MovieDetailModel({
    required super.id,
    required super.title,
    super.overview,
    super.posterPath,
    super.backdropPath,
    required super.voteAverage,
    required super.voteCount,
    super.releaseDate,
    super.genreIds,
    super.runtime,
    super.budget,
    super.revenue,
    super.tagline,
    super.genres,
    super.status,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    final genreList =
        (json['genres'] as List?)
            ?.map((g) => GenreModel.fromJson(g as Map<String, dynamic>))
            .toList() ??
        [];

    return MovieDetailModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? json['name'] as String? ?? '',
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      releaseDate:
          json['release_date'] as String? ?? json['first_air_date'] as String?,
      genreIds: genreList.map((g) => g.id).toList(),
      runtime: json['runtime'] as int?,
      budget: json['budget'] as int?,
      revenue: json['revenue'] as int?,
      tagline: json['tagline'] as String?,
      genres: genreList,
      status: json['status'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'release_date': releaseDate,
      'genre_ids': genreIds,
      'runtime': runtime,
      'budget': budget,
      'revenue': revenue,
      'tagline': tagline,
      'genres': genres.map((g) => {'id': g.id, 'name': g.name}).toList(),
      'status': status,
    };
  }
}
