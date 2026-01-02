import '../../../../core/network/tmdb_service.dart';
import '../../../home/data/models/movie_model.dart';
import '../../../home/domain/entities/movie_entity.dart';
import '../../domain/entities/cast_entity.dart';
import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/repositories/movie_detail_repository.dart';
import '../models/cast_model.dart';
import '../models/movie_detail_model.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final TmdbService _tmdbService = TmdbService();

  @override
  Future<MovieDetailEntity> getMovieDetail(int movieId) async {
    final json = await _tmdbService.getMovieDetails(movieId);
    return MovieDetailModel.fromJson(json);
  }

  @override
  Future<List<CastEntity>> getMovieCast(int movieId) async {
    final json = await _tmdbService.getMovieDetails(movieId);
    final credits = json['credits'] as Map<String, dynamic>?;
    final castList = credits?['cast'] as List? ?? [];

    return castList
        .take(20) // Limit to top 20 cast members
        .map((c) => CastModel.fromJson(c as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<MovieEntity>> getRecommendations(int movieId) async {
    final json = await _tmdbService.getMovieDetails(movieId);
    final recommendations = json['recommendations'] as Map<String, dynamic>?;
    final results = recommendations?['results'] as List? ?? [];

    return results
        .take(10) // Limit to 10 recommendations
        .map((r) => MovieModel.fromJson(r as Map<String, dynamic>))
        .toList();
  }
}
