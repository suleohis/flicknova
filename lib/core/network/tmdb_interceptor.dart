import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../env/env.dart';

class TmdbInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Primary: Bearer token in Authorization header
    options.headers['Authorization'] = 'Bearer ${Env.tmdbApiKey}';

    // Required accept header
    options.headers['Accept'] = 'application/json';

    // Optional fallback: remove if you fully switch
    // options.queryParameters['api_key'] = Env.tmdbApiKey;

    super.onRequest(options, handler);
  }
}

final prettyDioLogger = PrettyDioLogger(
  requestHeader: true,
  requestBody: true,
  responseBody: true,
  responseHeader: false,
  error: true,
  compact: false,
  maxWidth: 120,
);