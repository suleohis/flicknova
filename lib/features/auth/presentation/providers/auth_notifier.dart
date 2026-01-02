import 'package:flicknova/core/models/profile_entity.dart';
import 'package:flicknova/core/network/tmdb_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/genre_model.dart';
import '../../../../core/models/profile_model.dart';
import '../../../../routes/app_router.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_with_apple_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';

class AuthState {
  final UserEntity? user;
  final ProfileModel? profile;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.profile,
    this.isLoading = false,
    this.error,
  });

  // Fixed: Proper copyWith method
  AuthState copyWith({
    UserEntity? user,
    ProfileModel? profile,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  late final SignInWithGoogleUseCase _signInWithGoogle;
  late final SignInWithAppleUseCase _signInWithApple;
  late final AuthRepository _repository;

  @override
  AuthState build() {
    // Initialize dependencies in build method, not constructor
    _repository = AuthRepositoryImpl();
    _signInWithGoogle = SignInWithGoogleUseCase(_repository);
    _signInWithApple = SignInWithAppleUseCase(_repository);

    // Listen to auth state changes
    _repository.currentUser.listen((user) {
      state = state.copyWith(user: user);
    });

    return AuthState();
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _signInWithGoogle(context);
      state = state.copyWith(user: user, isLoading: false);

      // Wait for profile to be fetched
      await getCurrentProfile();

      if (!context.mounted) return;

      if (state.profile?.favoriteGenres == null || state.profile!.favoriteGenres!.isEmpty) {
        context.go(AppRouter.favoriteGenre); // Use .go instead of .push
      } else {
        context.go(AppRouter.dashboard);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Sign in error: $e');
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign in failed: $e')),
        );
      }
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _signInWithApple(context);
      state = state.copyWith(user: user, isLoading: false);

      // Wait for profile to be fetched
      await getCurrentProfile();

      if (!context.mounted) return;

      if (state.profile?.favoriteGenres == null || state.profile!.favoriteGenres!.isEmpty) {
        context.go(AppRouter.favoriteGenre);
      } else {
        context.go(AppRouter.dashboard);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Sign in error: $e');
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign in failed: $e')),
        );
      }
    }
  }

  void toggleFavoriteGenre(GenreModel genre) {
    // Check if profile exists
    if (state.profile == null) {
      if (kDebugMode) {
        print('Cannot toggle genre: Profile is null');
      }
      return;
    }

    // Create a new list to trigger state update
    final currentGenres = state.profile!.favoriteGenres ?? [];
    final updatedGenres = List<GenreModel>.from(currentGenres);

    if (updatedGenres.any((g) => g.id == genre.id)) {
      updatedGenres.removeWhere((g) => g.id == genre.id);
      if (kDebugMode) {
        print('Removed genre: ${genre.name}');
      }
    } else {
      updatedGenres.add(genre);
      if (kDebugMode) {
        print('Added genre: ${genre.name}');
      }
    }

    // Update state with new profile
    var updatedProfile = state.profile!;
     updatedProfile.favoriteGenres = updatedGenres;
    state = state.copyWith(profile: updatedProfile);

    if (kDebugMode) {
      print('Updated favorite genres: ${updatedGenres.map((g) => g.name).toList()}');
    }
  }

  Future<void> saveFavoriteGenres(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      // Save the profile with updated genres
      if (state.profile != null) {
        await _repository.updateProfile(state.profile!);

        state = state.copyWith(isLoading: false);

        if (!context.mounted) return;
        context.go(AppRouter.dashboard);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Save genres error: $e');
      }
    }
  }

  Future<void> getCurrentProfile() async {
    state = state.copyWith(isLoading: true);
    try {
      final profile = await _repository.getCurrentProfile();
      state = state.copyWith(profile: profile, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Get profile error: $e');
      }
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    try {
      await _repository.signOut();
      state = AuthState(); // Reset to initial state
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Sign out error: $e');
      }
    }
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

final movieGenresProvider = FutureProvider<List<GenreModel>>((ref) async {
  final genresJson = await TmdbService().getMovieGenres();
  // Convert to GenreModel list
  return genresJson.map((json) => GenreModel.fromJson(json)).toList();
});