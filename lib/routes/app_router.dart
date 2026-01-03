// lib/routes/app_router.dart
import 'package:flicknova/routes/routes/auth_route.dart';
import 'package:flicknova/routes/routes/main_route.dart';
import 'package:flicknova/routes/routes/splash_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'router_observer.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey(
  debugLabel: 'root',
);

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    restorationScopeId: 'router',
    navigatorKey: rootNavigatorKey,
    observers: [AppRouterObserver()],
    initialLocation: AppRouter.splash,
    routes: [
      splashRoute,
      welcomeRoute,
      onboardingRoute,
      ...mainRoutes,
      ...authRoutes,
      ...mainRoutes,
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '404 - Page not found\n${state.uri}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
});

// Clean path constants
class AppRouter {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String signIn = '/signIn';
  static const String favoriteGenre = '/favoriteGenre';
  static const String welcome = '/welcome';
  static const String dashboard = '/dashboard';
}
