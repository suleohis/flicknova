import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/person_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';
import '../providers/trending_notifier.dart';

class TrendingPeopleWidget extends ConsumerWidget {
  const TrendingPeopleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingState = ref.watch(trendingProvider);

    if (trendingState.trendingPeople.isEmpty && !trendingState.isLoading) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text('Trending People', style: context.h3),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 160.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: trendingState.trendingPeople.length,
            itemBuilder: (context, index) {
              final person = trendingState.trendingPeople[index];
              return _TrendingPersonCard(person: person);
            },
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}

class _TrendingPersonCard extends StatelessWidget {
  final PersonEntity person;

  const _TrendingPersonCard({required this.person});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to person detail screen
      },
      child: Container(
        width: 100.w,
        margin: EdgeInsets.only(right: 16.w),
        child: Column(
          children: [
            // Circular profile image
            Container(
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white400.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: person.profilePath != null
                    ? CachedNetworkImage(
                        imageUrl: context.tmdbPosterUrl(person.profilePath),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.cardBackground,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.cardBackground,
                          child: Icon(
                            Icons.person,
                            color: AppColors.white400,
                            size: 40.sp,
                          ),
                        ),
                      )
                    : Container(
                        color: AppColors.cardBackground,
                        child: Icon(
                          Icons.person,
                          color: AppColors.white400,
                          size: 40.sp,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 8.h),
            // Person name
            Text(
              person.name,
              style: context.bodyMedium.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            // Known for department
            Text(
              person.knownForDepartment,
              style: context.caption.copyWith(
                fontSize: 11.sp,
                color: AppColors.white600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
