import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/common_detail_entities.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flicknova/features/movie_detail/presentation/widgets/expandable_synopsis.dart';
import 'package:flicknova/features/movie_detail/presentation/widgets/watchlist_button.dart';
import 'package:flicknova/features/tv_detail/presentation/providers/tv_detail_notifier.dart';
import 'package:flicknova/features/tv_detail/presentation/widgets/seasons_section.dart';
import 'package:flicknova/features/tv_detail/presentation/widgets/tv_metadata_row.dart';
import 'package:flicknova/features/tv_detail/presentation/widgets/tv_series_poster.dart';
import 'package:flicknova/generated/app_localizations.dart';
import 'package:flicknova/shared/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';

import '../../../../core/widgets/youtube_player_widget.dart';
import '../../../person_detail/presentation/screens/person_detail_screen.dart';

class TVDetailScreen extends ConsumerStatefulWidget {
  final int seriesId;

  const TVDetailScreen({super.key, required this.seriesId});

  @override
  ConsumerState<TVDetailScreen> createState() => _TVDetailScreenState();
}

class _TVDetailScreenState extends ConsumerState<TVDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(tvDetailProvider.notifier).loadTVSeriesDetail(widget.seriesId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final detailState = ref.watch(tvDetailProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.share, color: AppColors.white),
          //   onPressed: () {
          //     // TODO: Share TV series
          //   },
          // ),
        ],
      ),
      body: detailState.isLoading
          ? const Center(child: AppLoading())
          : detailState.series == null
          ? Center(
              child: Text(
                detailState.error ?? 'Failed to load TV series details',
                style: const TextStyle(color: AppColors.white),
              ),
            )
          : CustomScrollView(
              slivers: [
                // Hero section
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      // Backdrop
                      if (detailState.series!.backdropPath != null)
                        SizedBox(
                          height: 300.h,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: context.tmdbBackdropUrl(
                              detailState.series!.backdropPath,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      // Gradient overlay
                      Container(
                        height: 300.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.transparent,
                              AppColors.background.withValues(alpha: 0.7),
                              AppColors.background,
                            ],
                            stops: const [0.0, 0.7, 1.0],
                          ),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: EdgeInsets.only(top: 120.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 16.w),
                            // Poster
                            TVSeriesPoster(
                              posterPath: detailState.series!.posterPath,
                              width: 120,
                              height: 180,
                            ),
                            SizedBox(width: 16.w),
                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 40.h),
                                  // Title (split)
                                  _buildTitle(
                                    context,
                                    detailState.series!.name,
                                  ),
                                  SizedBox(height: 12.h),
                                  // Metadata
                                  TVMetadataRow(series: detailState.series!),
                                ],
                              ),
                            ),
                            SizedBox(width: 16.w),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Action buttons
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        if (detailState.series?.videos?.results.last.key!= null)
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => YouTubePlayerWidget(
                                    videoKey: detailState.series?.videos?.results.last.key ??'',
                                    title: detailState.series?.name ??''
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.playButton,
                              foregroundColor: AppColors.background,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            icon: Icon(Icons.play_arrow, size: 24.sp),
                            label: Text(s.play_trailer),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: WatchlistButton(
                            isInWatchlist: detailState.isInWatchlist,
                            isLoading: detailState.isTogglingWatchlist,
                            onTap: () => ref
                                .read(tvDetailProvider.notifier)
                                .toggleWatchlist(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Synopsis
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.synopsis, style: context.h4),
                        SizedBox(height: 12.h),
                        ExpandableSynopsis(
                          text: detailState.series!.overview,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                // Cast
                if (detailState.series!.credits?.cast.isNotEmpty ?? false)
                  SliverToBoxAdapter(
                    child: _buildCastSection(
                      context,
                      detailState.series!.credits!.cast,
                    ),
                  ),

                SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                // Seasons
                SliverToBoxAdapter(
                  child: SeasonsSection(
                    seasons: detailState.series!.seasons,
                    seriesId: widget.seriesId,
                    seriesTitle: detailState.series!.name,
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 40.h)),
              ],
            ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    // Try to split title into main + subtitle
    final parts = title.split(' ');
    if (parts.length > 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(parts.first, style: context.h1.copyWith(fontSize: 32.sp)),
          Text(
            parts.sublist(1).join(' '),
            style: context.h1.copyWith(
              fontSize: 32.sp,
              color: AppColors.linkColor,
            ),
          ),
        ],
      );
    }
    return Text(title, style: context.h1.copyWith(fontSize: 32.sp));
  }

  Widget _buildCastSection(BuildContext context, List<CastMemberEntity> cast) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Top Cast', style: context.h4),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: context.bodyMedium.copyWith(
                    color: AppColors.linkColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: cast.take(10).length,
            itemBuilder: (context, index) {
              final actor = cast[index];
              return _buildCastCard(context, actor);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCastCard(BuildContext context, CastMemberEntity actor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PersonDetailScreen(personId: actor.id),
          ),
        );
      },
      child: Container(
        width: 80.w,
        margin: EdgeInsets.only(right: 12.w),
        child: Column(
          children: [
            Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white400.withValues(alpha: 0.2),
                ),
              ),
              child: ClipOval(
                child: actor.profilePath != null
                    ? CachedNetworkImage(
                        imageUrl: context.tmdbPosterUrl(actor.profilePath),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            Icon(Icons.person, color: AppColors.white400),
                      )
                    : Icon(Icons.person, color: AppColors.white400),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              actor.name,
              style: context.bodySmall.copyWith(fontSize: 11.sp),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
