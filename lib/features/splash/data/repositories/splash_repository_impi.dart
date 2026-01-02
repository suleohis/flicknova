import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/models/profile_entity.dart';
import '../../../../core/models/profile_model.dart';
import '../../../../core/utils/api_const.dart';
import '../../domain/repositories/splash_repository.dart';

class SplashRepositoryImpi extends SplashRepository {
  final SupabaseClient _client = Supabase.instance.client;
  @override
  Future<ProfileEntity?>  getCurrentProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    final response = await _client.from(ApiConst.profiles).select().eq(ApiConst.id, user.id).single();

    return ProfileModel.fromJson(response);
  }
}