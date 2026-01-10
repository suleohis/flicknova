import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../../movie_detail/presentation/screens/movie_detail_screen.dart';
import '../../../watchlist/presentation/providers/watchlist_notifier.dart';
import '../providers/profile_stats_notifier.dart';
import '../widgets/genre_chart.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_header.dart';
import '../widgets/recent_ratings_section.dart';
import '../widgets/settings_section.dart';
import '../widgets/user_stats_row.dart';
import '../widgets/year_review_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final authState = ref.watch(authProvider);
    final statsState = ref.watch(profileStatsProvider);
    final watchlistState = ref.watch(watchlistProvider);

    final userName = authState.user?.displayName ?? 'Alex Rivers';
    final stats = statsState.stats;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: ProfileHeader(
        onSettings: () {
          // TODO: Navigate to settings detail screen
        },
      ),
      body: statsState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Avatar
                  ProfileAvatar(userName: userName),

                  // Stats row
                  if (stats != null)
                    UserStatsRow(
                      moviesWatched: stats.moviesWatched,
                      totalHours: stats.totalHours,
                      avgRating: stats.avgRating,
                    ),

                  SizedBox(height: 24.h),

                  // Genre chart
                  if (stats != null && stats.genreDistribution.isNotEmpty)
                    GenreChart(genreDistribution: stats.genreDistribution),

                  // Year in review card
                  YearReviewCard(
                    onTap: () {
                      // TODO: Navigate to year recap screen
                    },
                  ),

                  SizedBox(height: 16.h),

                  // Recent ratings
                  if (watchlistState.items.isNotEmpty)
                    RecentRatingsSection(
                      recentMovies: watchlistState.items,
                      onSeeAll: () {
                        // TODO: Navigate to all ratings screen
                      },
                      onMovieTap: (movie) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(movieId: movie.tmdbId, mediaType: movie.mediaType),
                          ),
                        );
                      },
                    ),

                  SizedBox(height: 16.h),

                  // Settings
                  SettingsSection(
                    onLogout: () {
                      _showLogoutDialog(context, ref, s);
                    },
                  ),

                  SizedBox(height: 32.h),

                  // App version
                  Text(
                    'FlickNova v1.0.0',
                    style: TextStyle(
                      color: AppColors.white600,
                      fontSize: 12.sp,
                    ),
                  ),

                  SizedBox(height: 16.h),
                ],
              ),
            ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref, S s) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: Text(s.log_out),
        content: Text(s.logout_confirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(s.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).signOut();
              // Navigate to auth screen (handled by auth state listener)
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(s.log_out),
          ),
        ],
      ),
    );
  }
}
