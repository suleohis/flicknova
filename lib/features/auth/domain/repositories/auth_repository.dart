import 'package:flutter/material.dart';

import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signInWithGoogle(BuildContext context);
  Future<UserEntity> signInWithApple(BuildContext context);
  Future<void> signOut();
  Stream<UserEntity?> get currentUser;
}