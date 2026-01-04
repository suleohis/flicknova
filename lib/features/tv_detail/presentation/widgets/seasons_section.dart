import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/common_detail_entities.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flicknova/features/tv_detail/presentation/widgets/season_card.dart';
import 'package:flicknova/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/tv_series_detail_entity.dart';

class SeasonsSection extends StatelessWidget {
  final List<SeasonSummaryEntity> seasons;
  final int seriesId;
  final String seriesTitle;

  const SeasonsSection({
    super.key,
    required this.seasons,
    required this.seriesId,
    required this.seriesTitle,
  });

  @override
  Widget build(BuildContext context) {
    if (seasons.isEmpty) return const SizedBox.shrink();

    // Filter out "Specials" (season 0) and limit to regular seasons
    final regularSeasons = seasons.where((s) => s.seasonNumber > 0).toList();

    if (regularSeasons.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seasons',
            style: context.h4.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12.h),
          ...regularSeasons.map((season) {
            return SeasonCard(
              season: season,
              onTap: () {
                // Navigate to season detail with extra data
                context.push(
                  AppRouter.seasonDetail,
                  extra: {
                    'seriesId': seriesId,
                    'seasonNumber': season.seasonNumber,
                    'seriesTitle': seriesTitle,
                  },
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
