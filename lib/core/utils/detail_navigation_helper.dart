import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flicknova/routes/app_router.dart';

/// Helper class for routing to detail screens based on media type
class DetailNavigationHelper {
  /// Navigate to the appropriate detail screen based on media type
  ///
  /// [mediaType] should be 'movie', 'tv', or 'person'
  /// [id] is the TMDB ID for the entity
  static void navigateToDetail(
    BuildContext context, {
    required String mediaType,
    required int id,
  }) {
    switch (mediaType.toLowerCase()) {
      case 'movie':
        context.push(AppRouter.movieDetail, extra: id);
        break;
      case 'tv':
        context.push(AppRouter.tvDetail, extra: id);
        break;
      case 'person':
        context.push(AppRouter.personDetail, extra: id);
        break;
      default:
        // Log error or show error message
        debugPrint('Unknown media type: $mediaType');
    }
  }

  /// Get the route path for a given media type
  static String getRoutePath(String mediaType) {
    switch (mediaType.toLowerCase()) {
      case 'movie':
        return AppRouter.movieDetail;
      case 'tv':
        return AppRouter.tvDetail;
      case 'person':
        return AppRouter.personDetail;
      default:
        return AppRouter.dashboard;
    }
  }
}
