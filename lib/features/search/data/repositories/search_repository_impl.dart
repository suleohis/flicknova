import '../../../../core/network/tmdb_service.dart';
import '../../../home/data/models/movie_model.dart';
import '../../../home/domain/entities/movie_entity.dart';
import '../../domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final TmdbService _tmdbService = TmdbService();

  @override
  Future<List<MovieEntity>> searchContent({
    required String query,
    String category = 'all',
  }) async {
    if (query.isEmpty) return [];

    List<Map<String, dynamic>> results;

    switch (category) {
      case 'movie':
        results = await _tmdbService.searchMovies(query: query);
        break;
      case 'tv':
        results = await _tmdbService.searchTVShows(query: query);
        break;
      default:
        results = await _tmdbService.searchMulti(query: query);
    }

    return results.map((json) => MovieModel.fromJson(json)).toList();
  }
}
