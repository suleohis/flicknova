import 'package:flicknova/core/widgets/placeholder_detail_screen.dart';
import 'package:flicknova/features/movie_detail/presentation/screens/movie_detail_screen.dart';
import 'package:go_router/go_router.dart';

import '../app_router.dart';

List<GoRoute> detailRoutes = [
  // Movie Detail
  GoRoute(
    path: AppRouter.movieDetail,
    pageBuilder: (context, state) {
      final movieId = state.extra as int;
      return NoTransitionPage(child: MovieDetailScreen(movieId: movieId));
    },
  ),

  // TV Detail (Placeholder)
  GoRoute(
    path: AppRouter.tvDetail,
    pageBuilder: (context, state) {
      final seriesId = state.extra as int;
      return NoTransitionPage(
        child: PlaceholderDetailScreen(
          title: 'TV Show Detail',
          message: 'TV detail screen\ncoming soon',
          id: seriesId,
        ),
      );
    },
  ),

  // Person Detail (Placeholder)
  GoRoute(
    path: AppRouter.personDetail,
    pageBuilder: (context, state) {
      final personId = state.extra as int;
      return NoTransitionPage(
        child: PlaceholderDetailScreen(
          title: 'Person Detail',
          message: 'Person detail screen\ncoming soon',
          id: personId,
        ),
      );
    },
  ),
];
