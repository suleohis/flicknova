import '../../../../core/network/tmdb_service.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/movie_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final TmdbService _tmdbService = TmdbService();

  @override
  Future<List<MovieEntity>> getTrendingMovies() async {
    final jsonList = await _tmdbService.getTrending(
      mediaType: 'movie',
      timeWindow: 'week',
    );
    return jsonList.map((json) => MovieModel.fromJson(json)).toList();
  }

  @override
  Future<List<MovieEntity>> getPopularMovies() async {
    final jsonList = await _tmdbService.getPopularMovies();
    return jsonList.map((json) => MovieModel.fromJson(json)).toList();
  }

  @override
  Future<List<MovieEntity>> getTopRatedMovies() async {
    final jsonList = await _tmdbService.getTopRatedMovies();
    return jsonList.map((json) => MovieModel.fromJson(json)).toList();
  }

  @override
  Future<List<MovieEntity>> getNewReleases() async {
    final jsonList = await _tmdbService.getUpcomingMovies();
    return jsonList.map((json) => MovieModel.fromJson(json)).toList();
  }
}
