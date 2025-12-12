// lib/routes/router_observer.dart
import 'package:flutter/material.dart';

// Used by AppsFlyer, Firebase Analytics, Mixpanel, etc.
class AppRouterObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _logNavigation(route.settings.name ?? 'unknown');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _logNavigation(previousRoute?.settings.name ?? 'unknown');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logNavigation(newRoute?.settings.name ?? 'unknown');
  }

  void _logNavigation(String? screenName) {
    // Replace with your analytics
    debugPrint('→ Navigated to: $screenName');
    // FirebaseAnalytics.instance.setCurrentScreen(screenName: screenName);
  }
}