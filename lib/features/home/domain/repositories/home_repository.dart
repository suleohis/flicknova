import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/tv_show_entity.dart';

abstract class HomeRepository {
  Future<List<Map<String, dynamic>>> getTrendingAll();
  Future<List<MovieEntity>> getTrendingMovies();
  Future<List<TVShowEntity>> getTrendingTVShows();
  Future<List<MovieEntity>> getPopularMovies();
  Future<List<MovieEntity>> getTopRatedMovies();
  Future<List<MovieEntity>> getNewReleases();
  Future<List<Map<String, dynamic>>> getMovieVideos(int movieId);
  Future<List<Map<String, dynamic>>> getTVShowVideos(int tvShowId);
  Future<List> getPopularTVShows();
  Future<List> getPopularPeople();
}
