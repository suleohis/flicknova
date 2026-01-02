import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';

class EmptyWatchlist extends StatelessWidget {
  const EmptyWatchlist({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 80.sp, color: AppColors.white400),
          SizedBox(height: 24.h),
          Text(
            s.watchlist_empty,
            style: context.h3,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            s.watchlist_empty_message,
            style: context.bodyMedium.copyWith(color: AppColors.white600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
