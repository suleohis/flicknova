import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class SignInWithAppleUseCase {
  final AuthRepository repository;

  SignInWithAppleUseCase(this.repository);

  Future<UserEntity> call() async {
    return await repository.signInWithApple();
  }
}
