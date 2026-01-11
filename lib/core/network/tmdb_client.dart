import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';
import '../../env/env.dart';
import 'tmdb_exception.dart';
import 'tmdb_interceptor.dart';

class TmdbClient {
  static final TmdbClient _instance = TmdbClient._internal();
  factory TmdbClient() => _instance;
  TmdbClient._internal();

  late final Dio _dio;

  static const String _baseUrl = 'https://api.themoviedb.org/3';

  // TMDB-specific error code mapping
  static const Map<int, String> _tmdbErrorMessages = {
    1: 'Success',
    2: 'Invalid service: this service does not exist',
    3: 'Authentication failed',
    4: 'Invalid format',
    5: 'Invalid parameters',
    6: 'Invalid id',
    7: 'Invalid API key',
    8: 'Duplicate entry',
    9: 'Service offline',
    10: 'Suspended API key',
    11: 'Internal error',
    12: 'Item/record updated successfully',
    13: 'Item/record deleted successfully',
    14: 'Authentication failed',
    15: 'Failed',
    16: 'Device denied',
    17: 'Session denied',
    18: 'Validation failed',
    19: 'Invalid accept header',
    20: 'Invalid date range',
    21: 'Entry not found',
    22: 'Invalid page',
    23: 'Invalid date',
    24: 'Backend server timeout',
    25: 'Request limit exceeded (40 req/10s)',
    26: 'Username and password required',
    27: 'Too many append-to-response objects',
    28: 'Invalid timezone',
    29: 'Action not confirmed',
    30: 'Invalid username/password',
    31: 'Account disabled',
    32: 'Email not verified',
    33: 'Invalid request token',
    34: 'Resource not found',
    35: 'Invalid token',
    36: 'Token lacks write permission',
    37: 'Session not found',
    38: 'No permission to edit',
    39: 'Resource is private',
    40: 'Nothing to update',
    41: 'Request token not approved',
    42: 'HTTP method not supported',
    43: "Couldn't connect to backend",
    44: 'Invalid ID',
    45: 'User suspended',
    46: 'API under maintenance',
    47: 'Invalid input',
  };

  void init() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ));

    // Add interceptors
    _dio.interceptors.add(TmdbInterceptor());
    if (Env.enableLogging == 'true') {
      _dio.interceptors.add(prettyDioLogger);
    }
    // Aggressive caching (TMDB data rarely changes)
    _dio.interceptors.add(DioCacheInterceptor(
      options: CacheOptions(
        store: MemCacheStore(),
        policy: CachePolicy.refreshForceCache,
        hitCacheOnErrorCodes: [401, 403, 404],
        hitCacheOnNetworkFailure: true,
        maxStale: const Duration(days: 180),
        priority: CachePriority.high,
      ),
    ));
  }

  Future<Response<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e, stackTrace) {
      _handleDioError(e, stackTrace);
      rethrow;
    }
  }

  Future<Response<T>> post<T>(
      String path, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e, stackTrace) {
      _handleDioError(e, stackTrace);
      rethrow;
    }
  }

  Future<Response<T>> delete<T>(
      String path, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e, stackTrace) {
      _handleDioError(e, stackTrace);
      rethrow;
    }
  }

  // Optional: PUT if you ever need it
  Future<Response<T>> put<T>(
      String path, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e, stackTrace) {
      _handleDioError(e, stackTrace);
      rethrow;
    }
  }

  void _handleDioError(DioException error, StackTrace stackTrace) {
    final response = error.response;
    final statusCode = response?.statusCode ?? 0;

    // Extract TMDB-specific error code from response body
    final data = response?.data as Map<String, dynamic>?;
    final int? tmdbCode = data?['status_code'] as int?;
    final String tmdbMessage = data?['status_message'] as String? ??
        _tmdbErrorMessages[tmdbCode] ??
        'Unknown TMDB error';

    // Rate limit specific handling
    if (tmdbCode == 25 || statusCode == 429) {
      // final retryAfter = response?.headers.value('retry-after');
      // You could add exponential backoff here
    }

    final exception = TmdbException(
      tmdbCode: tmdbCode,
      message: tmdbMessage,
      statusCode: statusCode,
      stackTrace: Trace.from(stackTrace).terse,
    );

    // Log with full stack trace
    debugPrint('TMDB ERROR: $exception\n${exception.stackTrace}');

    throw exception;
  }
}