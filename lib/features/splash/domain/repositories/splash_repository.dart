import '../../../../core/models/profile_entity.dart';

abstract class SplashRepository {
  Future<ProfileEntity?> getCurrentProfile();
}