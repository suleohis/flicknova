import 'package:go_router/go_router.dart';

import '../../features/season/presentation/screens/season_detail_screen.dart';
import '../app_router.dart';

final seasonRoutes = [
  GoRoute(
    path: '${AppRouter.seasonDetail}/:tvId/:seasonNumber',
    builder: (context, state) {
      final tvId = int.parse(state.pathParameters['tvId']!);
      final seasonNumber = int.parse(state.pathParameters['seasonNumber']!);
      final showName = state.uri.queryParameters['showName'];

      return SeasonDetailScreen(
        tvId: tvId,
        seasonNumber: seasonNumber,
        showName: showName,
      );
    },
  ),
];
