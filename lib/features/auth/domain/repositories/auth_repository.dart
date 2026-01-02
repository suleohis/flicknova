import 'package:flutter/material.dart';

import '../../../../core/models/profile_entity.dart';
import '../../../../core/models/profile_model.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signInWithGoogle(BuildContext context);
  Future<UserEntity> signInWithApple(BuildContext context);
  Future<void> signOut();
  Stream<UserEntity?> get currentUser;
  Future<ProfileModel?> getCurrentProfile();
  Future<ProfileModel?> updateProfile(ProfileModel profile);
}