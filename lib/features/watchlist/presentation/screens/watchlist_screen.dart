import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../movie_detail/presentation/screens/movie_detail_screen.dart';
import '../providers/watchlist_notifier.dart';
import '../widgets/empty_watchlist.dart';
import '../widgets/hours_saved_badge.dart';
import '../widgets/watchlist_grid.dart';
import '../widgets/watchlist_header.dart';

class WatchlistScreen extends ConsumerWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlistState = ref.watch(watchlistProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            WatchlistHeader(
              isGridView: watchlistState.isGridView,
              onToggleView: () {
                ref.read(watchlistProvider.notifier).toggleViewMode();
              },
            ),

            // Hours saved badge
            if (watchlistState.items.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: HoursSavedBadge(hours: watchlistState.totalHoursSaved),
                ),
              ),

            // Watchlist grid or empty state
            Expanded(
              child: watchlistState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : watchlistState.items.isEmpty
                  ? const EmptyWatchlist()
                  : WatchlistGrid(
                      items: watchlistState.items,
                      isGridView: watchlistState.isGridView,
                      onItemTap: (item) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(movieId: item.id),
                          ),
                        );
                      },
                      onItemRemove: (item) {
                        // Show confirmation dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: AppColors.cardBackground,
                            title: const Text('Remove from Watchlist'),
                            content: Text(
                              'Are you sure you want to remove "${item.title}" from your watchlist?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(watchlistProvider.notifier)
                                      .removeItem(item.id);
                                  Navigator.pop(context);
                                },
                                child: const Text('Remove'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to search/add screen
        },
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: AppColors.background, size: 32.sp),
      ),
    );
  }
}
