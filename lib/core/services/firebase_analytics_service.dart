import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';

/// Service for tracking user behavior and app performance using Firebase Analytics
class FirebaseAnalyticsService {
  // Singleton pattern
  FirebaseAnalyticsService._();
  static final FirebaseAnalyticsService instance = FirebaseAnalyticsService._();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirebasePerformance _performance = FirebasePerformance.instance;

  // ============ Screen/Page View Tracking ============

  /// Log when a user views a screen
  Future<void> logScreenView(String screenName) async {
    try {
      await _analytics.logScreenView(screenName: screenName);
      debugPrint('📊 Analytics: Screen view - $screenName');
    } catch (e) {
      debugPrint('❌ Analytics Error (screen view): $e');
    }
  }

  // ============ Content Engagement Tracking ============

  /// Track when a user views a movie
  Future<void> logMovieView({
    required int movieId,
    required String title,
    String? genre,
    double? rating,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'movie_view',
        parameters: {
          'movie_id': movieId,
          'movie_title': title,
          if (genre != null) 'genre': genre,
          if (rating != null) 'rating': rating,
          'content_type': 'movie',
        },
      );
      debugPrint('📊 Analytics: Movie view - $title (ID: $movieId)');
    } catch (e) {
      debugPrint('❌ Analytics Error (movie view): $e');
    }
  }

  /// Track when a user views a TV show
  Future<void> logTVShowView({
    required int tvShowId,
    required String title,
    String? genre,
    double? rating,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'tv_show_view',
        parameters: {
          'tv_show_id': tvShowId,
          'tv_show_title': title,
          if (genre != null) 'genre': genre,
          if (rating != null) 'rating': rating,
          'content_type': 'tv_show',
        },
      );
      debugPrint('📊 Analytics: TV Show view - $title (ID: $tvShowId)');
    } catch (e) {
      debugPrint('❌ Analytics Error (TV show view): $e');
    }
  }

  /// Track when a user views a person/actor/director profile
  Future<void> logPersonView({
    required int personId,
    required String name,
    String? knownFor,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'person_view',
        parameters: {
          'person_id': personId,
          'person_name': name,
          if (knownFor != null) 'known_for': knownFor,
          'content_type': 'person',
        },
      );
      debugPrint('📊 Analytics: Person view - $name (ID: $personId)');
    } catch (e) {
      debugPrint('❌ Analytics Error (person view): $e');
    }
  }

  // ============ Search & Discovery Tracking ============

  /// Track search queries and results
  Future<void> logSearch({
    required String query,
    required int resultCount,
    String? selectedResultType,
  }) async {
    try {
      await _analytics.logSearch(
        searchTerm: query,
        numberOfNights: resultCount, // Reusing this parameter for result count
        numberOfRooms: selectedResultType != null ? 1 : 0,
      );
      debugPrint('📊 Analytics: Search - "$query" ($resultCount results)');
    } catch (e) {
      debugPrint('❌ Analytics Error (search): $e');
    }
  }

  // ============ Watchlist Tracking ============

  /// Track watchlist actions (add/remove)
  Future<void> logWatchlistAction({
    required String action, // 'add' or 'remove'
    required String mediaType, // 'movie' or 'tv_show'
    required String title,
    int? contentId,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'watchlist_action',
        parameters: {
          'action': action,
          'media_type': mediaType,
          'title': title,
          if (contentId != null) 'content_id': contentId,
        },
      );
      debugPrint('📊 Analytics: Watchlist $action - $title ($mediaType)');
    } catch (e) {
      debugPrint('❌ Analytics Error (watchlist): $e');
    }
  }

  // ============ Genre & Preference Tracking ============

  /// Track when a user interacts with a specific genre
  Future<void> logGenreInteraction({
    required String genre,
    required String interactionType, // 'filter', 'view', 'select'
  }) async {
    try {
      await _analytics.logEvent(
        name: 'genre_interaction',
        parameters: {'genre': genre, 'interaction_type': interactionType},
      );
      debugPrint('📊 Analytics: Genre interaction - $genre ($interactionType)');
    } catch (e) {
      debugPrint('❌ Analytics Error (genre interaction): $e');
    }
  }

  // ============ Video/Trailer Tracking ============

  /// Track when a user plays a trailer
  Future<void> logTrailerPlay({
    required String contentTitle,
    required String contentType, // 'movie' or 'tv_show'
    int? contentId,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'trailer_play',
        parameters: {
          'content_title': contentTitle,
          'content_type': contentType,
          if (contentId != null) 'content_id': contentId,
        },
      );
      debugPrint('📊 Analytics: Trailer play - $contentTitle');
    } catch (e) {
      debugPrint('❌ Analytics Error (trailer play): $e');
    }
  }

  // ============ User Properties ============

  /// Set user properties for segmentation
  Future<void> setUserProperties({
    String? favoriteGenre,
    String? preferredLanguage,
    int? contentViewCount,
  }) async {
    try {
      if (favoriteGenre != null) {
        await _analytics.setUserProperty(
          name: 'favorite_genre',
          value: favoriteGenre,
        );
      }
      if (preferredLanguage != null) {
        await _analytics.setUserProperty(
          name: 'preferred_language',
          value: preferredLanguage,
        );
      }
      debugPrint('📊 Analytics: User properties updated');
    } catch (e) {
      debugPrint('❌ Analytics Error (user properties): $e');
    }
  }

  /// Set user ID for tracking across sessions
  Future<void> setUserId(String userId) async {
    try {
      await _analytics.setUserId(id: userId);
      debugPrint('📊 Analytics: User ID set - $userId');
    } catch (e) {
      debugPrint('❌ Analytics Error (set user ID): $e');
    }
  }

  // ============ Performance Monitoring ============

  /// Create a custom trace for performance monitoring
  Trace? startTrace(String traceName) {
    try {
      final trace = _performance.newTrace(traceName);
      trace.start();
      debugPrint('⚡ Performance: Started trace - $traceName');
      return trace;
    } catch (e) {
      debugPrint('❌ Performance Error (start trace): $e');
      return null;
    }
  }

  /// Stop a performance trace
  Future<void> stopTrace(Trace? trace) async {
    try {
      if (trace != null) {
        await trace.stop();
        debugPrint('⚡ Performance: Stopped trace');
      }
    } catch (e) {
      debugPrint('❌ Performance Error (stop trace): $e');
    }
  }

  /// Track app open events
  Future<void> logAppOpen() async {
    try {
      await _analytics.logAppOpen();
      debugPrint('📊 Analytics: App opened');
    } catch (e) {
      debugPrint('❌ Analytics Error (app open): $e');
    }
  }
}
