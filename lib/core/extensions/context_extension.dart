import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../network/tmdb_service.dart';

extension TmdbImage on BuildContext {
  String tmdbBackdropUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    final bool isLargeScreen = ScreenUtil().screenWidth > 600;
    final size = isLargeScreen
        ? TmdbService.backdropSizeLarge
        : TmdbService.backdropSize;
    return '${TmdbService.baseImageUrl}$size$path';
  }

  String tmdbPosterUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    final bool isLargeScreen = ScreenUtil().screenWidth > 600;
    final size = isLargeScreen
        ? TmdbService.posterSizeLarge
        : TmdbService.posterSize;
    return '${TmdbService.baseImageUrl}$size$path';
  }

  String tmdbProfileUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '${TmdbService.baseImageUrl}${TmdbService.profileSize}$path';
  }
}
