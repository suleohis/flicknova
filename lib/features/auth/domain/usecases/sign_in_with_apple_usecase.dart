import 'package:flutter/cupertino.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class SignInWithAppleUseCase {
  final AuthRepository repository;

  SignInWithAppleUseCase(this.repository);

  Future<UserEntity> call(BuildContext context) async {
    return await repository.signInWithApple(context);
  }
}