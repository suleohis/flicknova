import 'package:flicknova/features/auth/presentation/screen/sign_in_screen.dart';
import 'package:go_router/go_router.dart';

import '../app_router.dart';

List<GoRoute> authRoutes = [
  GoRoute(
    path: AppRouter.signIn,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: SignInScreen(),
    ),
  )
];