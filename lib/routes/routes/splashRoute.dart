
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/screen/splash_screen.dart';
import '../app_router.dart';

final splashRoute = GoRoute(
  path: AppRouter.splash,
  pageBuilder: (context, state) => const NoTransitionPage(
    child: SplashScreen(),
  ),
);