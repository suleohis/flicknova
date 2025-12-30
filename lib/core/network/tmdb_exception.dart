class TmdbException implements Exception {
  final int? tmdbCode;
  final String message;
  final int statusCode;
  final StackTrace stackTrace;

  TmdbException({
    required this.tmdbCode,
    required this.message,
    required this.statusCode,
    required this.stackTrace,
  });

  @override
  String toString() => 'TmdbException($tmdbCode): $message (HTTP $statusCode)';
}