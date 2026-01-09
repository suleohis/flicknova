import 'package:go_router/go_router.dart';

import '../../features/season/presentation/screens/season_detail_screen.dart';
import '../app_router.dart';

final seasonRoutes = [
  GoRoute(
    path: AppRouter.seasonDetail,
    builder: (context, state) {
      Map extra = state.extra as Map;

      final tvId = extra['seriesId'];
      final seasonNumber  =extra['seasonNumber'];
      final showName = extra['seriesTitle'];

      return SeasonDetailScreen(
        tvId: tvId,
        seasonNumber: seasonNumber,
        showName: showName,
      );
    },
  ),
];
