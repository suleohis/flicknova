import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../shared/app_loading.dart';
import '../providers/season_notifier.dart';
import '../widgets/episode_card.dart';

class SeasonDetailScreen extends ConsumerStatefulWidget {
  final int tvId;
  final int seasonNumber;
  final String? showName;

  const SeasonDetailScreen({
    super.key,
    required this.tvId,
    required this.seasonNumber,
    this.showName,
  });

  @override
  ConsumerState<SeasonDetailScreen> createState() => _SeasonDetailScreenState();
}

class _SeasonDetailScreenState extends ConsumerState<SeasonDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(seasonProvider.notifier)
          .loadSeasonDetails(
            tvId: widget.tvId,
            seasonNumber: widget.seasonNumber,
            showName: widget.showName,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final seasonState = ref.watch(seasonProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.more_vert, color: AppColors.white),
          //   onPressed: () {
          //     // TODO: Show options menu
          //   },
          // ),
        ],
      ),
      body: seasonState.isLoading
          ? const Center(child: AppLoading())
          : seasonState.error != null
          ? ErrorStateWidget(
              message: seasonState.error!,
              onRetry: () {
                ref
                    .read(seasonProvider.notifier)
                    .loadSeasonDetails(
                      tvId: widget.tvId,
                      seasonNumber: widget.seasonNumber,
                      showName: widget.showName,
                    );
              },
            )
          : seasonState.season != null
          ? _buildSeasonContent(seasonState)
          : const SizedBox.shrink(),
    );
  }

  Widget _buildSeasonContent(SeasonState seasonState) {
    final season = seasonState.season!;
    final showName = seasonState.showName ?? '';
    final year = season.airDate != null && season.airDate!.length >= 4
        ? season.airDate!.substring(0, 4)
        : '';

    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show name
                if (showName.isNotEmpty) ...[
                  Text(
                    showName.toUpperCase(),
                    style: TextStyle(
                      color: AppColors.trendingBadge,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],

                // Season name
                Text(
                  season.name,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.h),

                // Episode count, rating, year
                Row(
                  children: [
                    Text(
                      '${season.episodes.length} Episodes',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (year.isNotEmpty) ...[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.white600,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'TV-MA',
                          style: TextStyle(
                            color: AppColors.white600,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        year,
                        style: TextStyle(
                          color: AppColors.white600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),

        // Episodes list
        SliverPadding(
          padding: EdgeInsets.all(16.w),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return EpisodeCard(
                episode: season.episodes[index],
                onTap: () {
                  // TODO: Navigate to episode detail or play
                },
              );
            }, childCount: season.episodes.length),
          ),
        ),
      ],
    );
  }
}
