
import 'package:flicknova/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/screen/splash_screen.dart';
import '../../features/welcome/presentation/screen/welcome_screen.dart';
import '../app_router.dart';

final splashRoute = GoRoute(
  path: AppRouter.splash,
  pageBuilder: (context, state) => const NoTransitionPage(
    child: SplashScreen(),
  ),
);

final welcomeRoute = GoRoute(
  path: AppRouter.welcome,
  pageBuilder: (context, state) => const NoTransitionPage(
    child: WelcomeScreen(),
  ),
);
final onboardingRoute = GoRoute(
  path: AppRouter.onboarding,
  pageBuilder: (context, state) => const NoTransitionPage(
    child: OnboardingScreen(),
  ),
);