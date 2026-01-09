import 'package:flicknova/core/models/genre_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/person_entity.dart';
import '../../../../core/models/profile_model.dart';
import '../../../../core/models/tv_show_entity.dart';
import '../../../../core/network/tmdb_service.dart';
import '../../../../core/utils/api_const.dart';
import '../../domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final TmdbService _tmdbService = TmdbService();
  final SupabaseClient _client = Supabase.instance.client;

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

  @override
  Future<List<GenreModel>?> getGenres() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    final response = await _client
        .from(ApiConst.profiles)
        .select()
        .eq(ApiConst.id, user.id)
        .single();
    final profile = ProfileModel.fromJson(response);
    return profile.favoriteGenres ?? [];
  }
}
