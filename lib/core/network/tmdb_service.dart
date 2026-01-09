import 'package:flicknova/core/network/tmdb_client.dart';

class TmdbService {
  static final TmdbService _instance = TmdbService._internal();
  factory TmdbService() => _instance;
  TmdbService._internal();

  final TmdbClient _client = TmdbClient();

  // Image base URLs
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/';

  // Phone screens (design 402×804, up to 3x density)
  static const String backdropSize =
      'w780'; // Perfect for hero backdrop (780px wide → crisp on phone)
  static const String posterSize =
      'w342'; // Standard portrait poster in grids (342px → ~114dp at 3x)
  static const String profileSize = 'w185'; // Cast headshots
  static const String logoSize = 'w300'; // Studio/network logos

  // Fallback for larger screens (web/desktop) – use in responsive logic
  static const String backdropSizeLarge = 'w1280';
  static const String posterSizeLarge = 'w500';

  Future<List<Map<String, dynamic>>> getMovieGenres({
    String language = 'en-US',
  }) async {
    final response = await _client.get(
      '/genre/movie/list',
      queryParameters: {'language': language},
    );
    return (response.data['genres'] as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getTVShowGenres({
    String language = 'en-US',
  }) async {
    final response = await _client.get(
      '/genre/tv/list',
      queryParameters: {'language': language},
    );
    return (response.data['genres'] as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getTvGenres({
    String language = 'en-US',
  }) async {
    final response = await _client.get(
      '/genre/tv//list',
      queryParameters: {'language': language},
    );
    return (response.data['genres'] as List).cast<Map<String, dynamic>>();
  }

  // ============================================================================
  // DETAIL API METHODS
  // ============================================================================

  /// Get detailed movie information by ID
  /// Includes: credits (cast/crew), videos, images, and recommendations
  Future<Map<String, dynamic>> getMovieDetails(
    int movieId, {
    String language = 'en-US',
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/movie/$movieId',
      queryParameters: {
        'language': language,
        'append_to_response': 'credits,videos,images,recommendations',
      },
    );
    return response.data as Map<String, dynamic>;
  }

  /// Get detailed person information by ID
  /// Includes: TV credits (cast/crew)
  Future<Map<String, dynamic>> getPersonDetails(
    int personId, {
    String language = 'en-US',
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/person/$personId',
      queryParameters: {
        'language': language,
        'append_to_response': 'tv_credits,movie_credits',
      },
    );
    return response.data as Map<String, dynamic>;
  }

  /// Get detailed TV series information by ID
  /// Includes: credits (cast/crew), videos, and images
  Future<Map<String, dynamic>> getTVSeriesDetails(
    int seriesId, {
    String language = 'en-US',
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/tv/$seriesId',
      queryParameters: {
        'language': language,
        'append_to_response': 'credits,videos,images',
      },
    );
    return response.data as Map<String, dynamic>;
  }

  /// Get detailed season information for a TV series
  /// Includes all episodes with their crew and guest stars
  Future<Map<String, dynamic>> getSeasonDetails(
    int seriesId,
    int seasonNumber, {
    String language = 'en-US',
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/tv/$seriesId/season/$seasonNumber',
      queryParameters: {'language': language},
    );
    return response.data as Map<String, dynamic>;
  }

  /// Get detailed episode information
  Future<Map<String, dynamic>> getEpisodeDetails(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
    String language = 'en-US',
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/tv/$seriesId/season/$seasonNumber/episode/$episodeNumber',
      queryParameters: {'language': language},
    );
    return response.data as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> getTrending({
    String mediaType = 'movie',
    String timeWindow = 'week',
    String language = 'en-US',
  }) async {
    final response = await _client.get(
      '/trending/$mediaType/$timeWindow',
      queryParameters: {'language': language},
    );
    return (response.data['results'] as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> getTrendingMap({
    String mediaType = 'movie',
    String timeWindow = 'week',
    String language = 'en-US',
  }) async {
    final response = await _client.get(
      '/trending/$mediaType/$timeWindow',
      queryParameters: {'language': language},
    );
    return response.data as Map<String, dynamic>;
  }

  // Specific trending methods
  Future<Map<String, dynamic>> getTrendingMovies({
    String timeWindow = 'day', // 'day' or 'week'
    String language = 'en-US',
  }) async {
    final response = await _client.get(
      '/trending/movie/$timeWindow',
      queryParameters: {'language': language},
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getTrendingTV({
    String timeWindow = 'day', // 'day' or 'week'
    String language = 'en-US',
  }) async {
    final response = await _client.get(
      '/trending/tv/$timeWindow',
      queryParameters: {'language': language},
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getTrendingPeople({
    String timeWindow = 'day', // 'day' or 'week'
    String language = 'en-US',
  }) async {
    final response = await _client.get(
      '/trending/person/$timeWindow',
      queryParameters: {'language': language},
    );
    return response.data as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> getPopularMovies({
    String language = 'en-US',
    int page = 1,
  }) async {
    final response = await _client.get(
      '/movie/popular',
      queryParameters: {'language': language, 'page': page},
    );
    return (response.data['results'] as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getTopRatedMovies({
    String language = 'en-US',
    int page = 1,
    String? region, // ISO-3166-1 country code
  }) async {
    final queryParams = {
      'language': language,
      'page': page,
      if (region != null) 'region': region,
    };

    final response = await _client.get(
      '/movie/top_rated',
      queryParameters: queryParams,
    );
    return (response.data['results'] as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getNowPlayingMovies({
    String language = 'en-US',
    int page = 1,
  }) async {
    final response = await _client.get(
      '/movie/now_playing',
      queryParameters: {'language': language, 'page': page},
    );
    return (response.data['results'] as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getUpcomingMovies({
    String language = 'en-US',
    int page = 1,
  }) async {
    final response = await _client.get(
      '/movie/upcoming',
      queryParameters: {'language': language, 'page': page},
    );
    return (response.data['results'] as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> getPopularTV({
    String language = 'en-US',
    int page = 1,
  }) async {
    final response = await _client.get(
      '/tv/popular',
      queryParameters: {'language': language, 'page': page},
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getPopularPeople({
    String language = 'en-US',
    int page = 1,
  }) async {
    final response = await _client.get(
      '/person/popular',
      queryParameters: {'language': language, 'page': page},
    );
    return response.data as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> getMovieVideos(int movieId) async {
    final response = await _client.get('/movie/$movieId/videos');
    return (response.data['results'] as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getTVShowVideo(int tvShowId) async {
    final response = await _client.get('/tv/$tvShowId/videos');
    return (response.data['results'] as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> searchMulti({
    required String query,
    String language = 'en-US',
    int page = 1,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/search/multi',
      queryParameters: {'query': query, 'language': language, 'page': page},
    );
    return ((response.data as Map<String, dynamic>)['results'] as List)
        .cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> searchMovies({
    required String query,
    String language = 'en-US',
    int page = 1,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/search/movie',
      queryParameters: {'query': query, 'language': language, 'page': page},
    );
    return ((response.data as Map<String, dynamic>)['results'] as List)
        .cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> searchTVShows({
    required String query,
    String language = 'en-US',
    int page = 1,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/search/tv',
      queryParameters: {'query': query, 'language': language, 'page': page},
    );
    return ((response.data as Map<String, dynamic>)['results'] as List)
        .cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> searchPeople({
    required String query,
    String language = 'en-US',
    int page = 1,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/search/person',
      queryParameters: {'query': query, 'language': language, 'page': page},
    );
    return ((response.data as Map<String, dynamic>)['results'] as List)
        .cast<Map<String, dynamic>>();
  }
}
