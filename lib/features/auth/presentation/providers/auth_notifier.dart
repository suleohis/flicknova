import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_with_apple_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';

class AuthState {
  final UserEntity? user;
  final bool isLoading;
  final String? error;

  AuthState({this.user, this.isLoading = false, this.error});
}

class AuthNotifier extends Notifier<AuthState> {
  final SignInWithGoogleUseCase _signInWithGoogle;
  final SignInWithAppleUseCase _signInWithApple;
  final AuthRepository _repository;

  @override
  AuthState build() => AuthState();

  AuthNotifier()
      : _repository = AuthRepositoryImpl(),
        _signInWithGoogle = SignInWithGoogleUseCase(AuthRepositoryImpl()),
        _signInWithApple = SignInWithAppleUseCase(AuthRepositoryImpl()),
        super() {
    _repository.currentUser.listen((user) {
      state = AuthState(user: user);
    });
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    state = AuthState(isLoading: true);
    try {
      final user = await _signInWithGoogle(context);
      state = AuthState(user: user);
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    state = AuthState(isLoading: true);
    try {
      final user = await _signInWithApple(context);
      state = AuthState(user: user);
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    state = AuthState();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() => AuthNotifier());