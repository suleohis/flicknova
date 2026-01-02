import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';

class OverviewSection extends StatelessWidget {
  final String? overview;

  const OverviewSection({super.key, this.overview});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.overview, style: context.h4),
          SizedBox(height: 12.h),
          Text(
            overview ?? s.no_overview,
            style: context.body.copyWith(
              color: AppColors.white600,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
