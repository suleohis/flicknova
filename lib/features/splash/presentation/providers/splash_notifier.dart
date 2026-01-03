import 'package:flicknova/features/splash/data/repositories/splash_repository_impi.dart';
import 'package:flicknova/features/splash/domain/repositories/splash_repository.dart';
import 'package:flicknova/routes/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/profile_entity.dart';

class SplashState {
  final ProfileEntity? profile;
  final bool isLoading;
  final String? error;

  SplashState({this.profile, this.isLoading = false, this.error});
}

class SplashNotifier extends Notifier<SplashState> {
  final SplashRepository _repository;

  @override
  SplashState build() => SplashState();

  SplashNotifier() : _repository = SplashRepositoryImpi(), super();

  Future<void> getCurrentProfile(BuildContext context) async {
    state = SplashState(isLoading: true);
    try {
      final profile = await _repository.getCurrentProfile();
      state = SplashState(profile: profile);

      if (!context.mounted) return;

      if (profile == null) {
        context.push(AppRouter.welcome);
      } else if (profile.favoriteGenres == null) {
        context.go(AppRouter.favoriteGenre);
      } else {
        context.go(AppRouter.dashboard);
      }
    } catch (e) {
      state = SplashState(error: e.toString());
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

final splashNotifier = NotifierProvider<SplashNotifier, SplashState>(
  () => SplashNotifier(),
);
