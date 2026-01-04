import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/person_entity.dart';
import '../../../../core/models/tv_show_entity.dart';

abstract class SearchRepository {
  Future<List<MovieEntity>> searchMovies({required String query});
  Future<List<TVShowEntity>> searchTVShows({required String query});
  Future<List<PersonEntity>> searchPeople({required String query});
}
