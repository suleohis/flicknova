import 'package:flicknova/features/auth/presentation/screen/choose_favorite_genres_screen.dart';
import 'package:flicknova/features/auth/presentation/screen/sign_in_screen.dart';
import 'package:go_router/go_router.dart';

import '../app_router.dart';

List<GoRoute> authRoutes = [
  GoRoute(
    path: AppRouter.signIn,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: SignInScreen(),
    ),
  ),
  GoRoute(
    path: AppRouter.favoriteGenre,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: ChooseFavoriteGenresScreen(),
    ),
  )
];