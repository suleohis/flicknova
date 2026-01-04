import 'package:go_router/go_router.dart';

import '../../features/see_all/presentation/screens/see_all_screen.dart';
import '../app_router.dart';

final seeAllRoutes = [
  GoRoute(
    path: AppRouter.seeAll,
    builder: (context, state) {
      final contentType = state.uri.queryParameters['contentType'] ?? 'movie';
      final category = state.uri.queryParameters['category'] ?? 'popular';
      final title = state.uri.queryParameters['title'] ?? 'See All';

      return SeeAllScreen(
        contentType: contentType,
        category: category,
        title: title,
      );
    },
  ),
];
