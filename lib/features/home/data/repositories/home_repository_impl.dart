import 'dart:io';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/network/tmdb_service.dart';
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
    final jsonList = await _tmdbService.getTopRatedMovies(
      region: _getUserRegion(),
    );
    return jsonList.map((json) => MovieModel.fromJson(json)).toList();
  }

  /// Get user's region for top rated content
  /// Uses device locale to determine country code
  String _getUserRegion() {
    try {
      final locale = Platform.localeName;
      if (locale.contains('_')) {
        final parts = locale.split('_');
        if (parts.length >= 2) {
          final region = parts[1].toUpperCase();
          // Return country code without locale modifiers
          return region.contains('.') ? region.split('.')[0] : region;
        }
      }
    } catch (e) {
      // Ignore errors
    }
    return 'US'; // Default to US
  }

  @override
  Future<List<MovieEntity>> getNewReleases() async {
    final jsonList = await _tmdbService.getUpcomingMovies();
    return jsonList.map((json) => MovieModel.fromJson(json)).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getMovieVideos(int movieId) async {
    return await _tmdbService.getMovieVideos(movieId);
  }

  @override
  Future<List> getPopularTVShows() async {
    final data = await _tmdbService.getPopularTV();
    return data['results'] as List;
  }

  @override
  Future<List> getPopularPeople() async {
    final data = await _tmdbService.getPopularPeople();
    return data['results'] as List;
  }
}
