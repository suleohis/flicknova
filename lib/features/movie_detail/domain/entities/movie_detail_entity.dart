import '../../../home/domain/entities/movie_entity.dart';
import 'genre_entity.dart';

class MovieDetailEntity extends MovieEntity {
  final int? runtime;
  final int? budget;
  final int? revenue;
  final String? tagline;
  final List<GenreEntity> genres;
  final String status;

  MovieDetailEntity({
    required super.id,
    required super.title,
    super.overview,
    super.posterPath,
    super.backdropPath,
    required super.voteAverage,
    required super.voteCount,
    super.releaseDate,
    super.genreIds,
    this.runtime,
    this.budget,
    this.revenue,
    this.tagline,
    this.genres = const [],
    this.status = '',
  });
}
