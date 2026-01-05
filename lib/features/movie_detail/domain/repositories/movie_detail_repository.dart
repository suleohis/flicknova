import '../../../../core/models/movie_entity.dart';
import '../entities/cast_entity.dart';
import '../entities/movie_detail_entity.dart';

abstract class MovieDetailRepository {
  Future<MovieDetailEntity> getMovieDetail(int movieId);
  Future<List<CastEntity>> getMovieCast(int movieId);
  Future<List<MovieEntity>> getRecommendations(int movieId);
}
