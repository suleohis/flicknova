import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/screen/dashboard_screen.dart';
import '../app_router.dart';

List<GoRoute> mainRoutes = [
  GoRoute(
    path: AppRouter.dashboard,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: DashboardScreen(),
    ),
  ),
];