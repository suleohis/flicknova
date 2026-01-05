import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/features/movie_detail/presentation/widgets/expandable_synopsis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiographySection extends StatelessWidget {
  final String biography;

  const BiographySection({super.key, required this.biography});

  @override
  Widget build(BuildContext context) {
    if (biography.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Biography',
            style: context.h4.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12.h),
          ExpandableSynopsis(
            text: biography,
            maxLines: 4,
            readMoreText: 'Read More',
            showLessText: 'Show Less',
          ),
        ],
      ),
    );
  }
}
