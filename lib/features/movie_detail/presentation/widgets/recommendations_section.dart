import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../generated/app_localizations.dart';
import '../../../home/presentation/widgets/movie_card.dart';
import '../../../home/presentation/widgets/section_header.dart';

class RecommendationsSection extends StatelessWidget {
  final List<MovieEntity> recommendations;
  final Function(MovieEntity)? onMovieTap;

  const RecommendationsSection({
    super.key,
    required this.recommendations,
    this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    if (recommendations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: s.you_may_also_like),
        SizedBox(
          height: 270.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: recommendations.length,
            itemBuilder: (context, index) {
              final movie = recommendations[index];
              return MovieCard(
                movie: movie,
                onTap: () => onMovieTap?.call(movie),
              );
            },
          ),
        ),
      ],
    );
  }
}
