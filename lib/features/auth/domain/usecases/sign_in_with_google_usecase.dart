import 'package:flicknova/features/auth/domain/entities/user_entity.dart';
import 'package:flicknova/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;

  SignInWithGoogleUseCase(this.repository);

  Future<UserEntity> call(BuildContext context) async {
    return await repository.signInWithGoogle(context);
  }
}