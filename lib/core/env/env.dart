import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'TMDB_API_KEY')
  static final String tmdbApiKey = _Env.tmdbApiKey;

  @EnviedField(varName: 'SUPABASE_URL')
  static final String supabaseUrl = _Env.supabaseUrl;

  @EnviedField(varName: 'SUPABASE_ANON_KEY')
  static final String supabaseAnonKey = _Env.supabaseAnonKey;

  @EnviedField(varName: 'SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET')
  static final String supabaseAuthGoogleSecret = _Env.supabaseAuthGoogleSecret;

  @EnviedField(varName: 'SUPABASE_SERVICE_ROLE_KEY')
  static final String supabaseServiceroleKey = _Env.supabaseServiceroleKey;

  @EnviedField(varName: 'DEBUG_SHOW_SHIMMER')
  static final String debugShowShimmer = _Env.debugShowShimmer;

  @EnviedField(varName: 'ENABLE_LOGGING')
  static final String enableLogging = _Env.enableLogging;
}