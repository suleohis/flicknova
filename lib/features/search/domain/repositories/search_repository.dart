import '../../../home/domain/entities/movie_entity.dart';

abstract class SearchRepository {
  Future<List<MovieEntity>> searchContent({
    required String query,
    String category = 'all', // 'all', 'movie', 'tv'
  });
}
