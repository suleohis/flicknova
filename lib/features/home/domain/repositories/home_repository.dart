import '../entities/movie_entity.dart';

abstract class HomeRepository {
  Future<List<MovieEntity>> getTrendingMovies();
  Future<List<MovieEntity>> getPopularMovies();
  Future<List<MovieEntity>> getTopRatedMovies();
  Future<List<MovieEntity>> getNewReleases();
}
