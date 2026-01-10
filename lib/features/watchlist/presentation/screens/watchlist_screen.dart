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
              onRefresh: () {
                ref.read(watchlistProvider.notifier).loadWatchlist();
              },
            ),

            // Filter tabs
            _buildFilterTabs(context, ref, watchlistState),

            // Hours saved badge and counts
            if (watchlistState.items.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    HoursSavedBadge(hours: watchlistState.totalHoursSaved),
                    SizedBox(width: 12.w),
                    if (watchlistState.selectedFilter == 'all') ...[
                      _buildCountBadge('${watchlistState.movieCount} Movies'),
                      SizedBox(width: 8.w),
                      _buildCountBadge(
                        '${watchlistState.tvShowCount} TV Shows',
                      ),
                    ],
                  ],
                ),
              ),

            // Watchlist grid or empty state
            Expanded(
              child: watchlistState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : watchlistState.filteredItems.isEmpty
                  ? const EmptyWatchlist()
                  : RefreshIndicator(
                      onRefresh: () {
                        return ref
                            .read(watchlistProvider.notifier)
                            .loadWatchlist();
                      },
                      child: WatchlistGrid(
                        items: watchlistState.filteredItems,
                        isGridView: watchlistState.isGridView,
                        onItemTap: (item) {
                          if (item.isMovie) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(
                                  movieId: item.tmdbId,
                                  mediaType: item.mediaType,
                                ),
                              ),
                            );
                          } else {
                            // TODO: Navigate to TV Detail Screen
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'TV show detail screen coming soon',
                                ),
                              ),
                            );
                          }
                        },
                        onItemRemove: (item) {
                          _showRemoveDialog(context, ref, item);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // TODO: Navigate to search/add screen
      //   },
      //   backgroundColor: AppColors.primary,
      //   child: Icon(Icons.add, color: AppColors.background, size: 32.sp),
      // ),
    );
  }

  Widget _buildFilterTabs(
    BuildContext context,
    WidgetRef ref,
    WatchlistState state,
  ) {
    final filters = [
      {'id': 'all', 'label': 'All'},
      {'id': 'movie', 'label': 'Movies'},
      {'id': 'tv', 'label': 'TV Shows'},
    ];

    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = state.selectedFilter == filter['id'];

          return GestureDetector(
            onTap: () {
              ref.read(watchlistProvider.notifier).setFilter(filter['id']!);
            },
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.trendingBadge
                    : AppColors.chipBackground,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: Text(
                  filter['label']!,
                  style: TextStyle(
                    color: isSelected ? AppColors.background : AppColors.white,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCountBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: TextStyle(color: AppColors.white600, fontSize: 12.sp),
      ),
    );
  }

  void _showRemoveDialog(BuildContext context, WidgetRef ref, dynamic item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text('Remove from Watchlist'),
        content: Text(
          'Are you sure you want to remove "${item.title}" from your watchlist?',
          style: TextStyle(color: AppColors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.white600)),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(watchlistProvider.notifier)
                  .removeItem(item.tmdbId, item.mediaType);
              Navigator.pop(context);
            },
            child: Text('Remove', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
