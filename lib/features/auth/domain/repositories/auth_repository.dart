import '../../../../core/models/profile_model.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signInWithGoogle();
  Future<UserEntity> signInWithApple();
  Future<void> signOut();
  Stream<UserEntity?> get currentUser;
  Future<ProfileModel?> getCurrentProfile();
  Future<ProfileModel?> updateProfile(ProfileModel profile);
}
