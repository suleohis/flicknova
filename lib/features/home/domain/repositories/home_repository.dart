import '../../../../core/models/movie_entity.dart';

abstract class HomeRepository {
  Future<List<MovieEntity>> getTrendingMovies();
  Future<List<MovieEntity>> getPopularMovies();
  Future<List<MovieEntity>> getTopRatedMovies();
  Future<List<MovieEntity>> getNewReleases();
  Future<List<Map<String, dynamic>>> getMovieVideos(int movieId);
  Future<List> getPopularTVShows();
  Future<List> getPopularPeople();
}
