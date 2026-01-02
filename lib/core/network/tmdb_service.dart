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

  Future<List<Map<String, dynamic>>> getTvGenres({
    String language = 'en-US',
  }) async {
    final response = await _client.get(
      '/genre/tv//list',
      queryParameters: {'language': language},
    );
    return (response.data['genres'] as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/movie/$movieId',
      queryParameters: {
        'append_to_response': 'credits,videos,images,recommendations',
      },
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
  }) async {
    final response = await _client.get(
      '/movie/top_rated',
      queryParameters: {'language': language, 'page': page},
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

  Future<List<Map<String, dynamic>>> getMovieVideos(int movieId) async {
    final response = await _client.get('/movie/$movieId/videos');
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
}
