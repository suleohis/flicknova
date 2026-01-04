import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/person_entity.dart';
import '../../../../core/models/tv_show_entity.dart';
import '../../../../core/network/tmdb_service.dart';
import '../../domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final TmdbService _tmdbService = TmdbService();

  @override
  Future<List<MovieEntity>> searchMovies({required String query}) async {
    if (query.isEmpty) return [];

    final results = await _tmdbService.searchMovies(query: query);
    return results.map((json) => MovieEntity.fromJson(json)).toList();
  }

  @override
  Future<List<TVShowEntity>> searchTVShows({required String query}) async {
    if (query.isEmpty) return [];

    final results = await _tmdbService.searchTVShows(query: query);
    return results.map((json) => TVShowEntity.fromJson(json)).toList();
  }

  @override
  Future<List<PersonEntity>> searchPeople({required String query}) async {
    if (query.isEmpty) return [];

    final results = await _tmdbService.searchPeople(query: query);
    return results.map((json) => PersonEntity.fromJson(json)).toList();
  }
}
