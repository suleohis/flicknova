import 'package:flicknova/features/movie_detail/presentation/screens/movie_detail_screen.dart';
import 'package:flicknova/features/person_detail/presentation/screens/person_detail_screen.dart';
import 'package:flicknova/features/tv_detail/presentation/screens/tv_detail_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/tv_detail/presentation/screens/top_cast_screen.dart';
import '../app_router.dart';

List<GoRoute> detailRoutes = [
  // Movie Detail
  GoRoute(
    path: AppRouter.movieDetail,
    pageBuilder: (context, state) {
      final movieId = state.extra as int;
      return NoTransitionPage(child: MovieDetailScreen(movieId: movieId, mediaType: 'movie',));
    },
  ),

  // TV Detail
  GoRoute(
    path: AppRouter.tvDetail,
    pageBuilder: (context, state) {
      final seriesId = state.extra as int;
      return NoTransitionPage(child: TVDetailScreen(seriesId: seriesId));
    },
  ),

  GoRoute(
    path: AppRouter.topCast,
    pageBuilder: (context, state) {
      return NoTransitionPage(child: TopCastScreen());
    },
  ),

  // Person Detail
  GoRoute(
    path: AppRouter.personDetail,
    pageBuilder: (context, state) {
      final personId = state.extra as int;
      return NoTransitionPage(child: PersonDetailScreen(personId: personId));
    },
  ),
];
