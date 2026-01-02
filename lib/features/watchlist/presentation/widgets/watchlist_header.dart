import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';

class WatchlistHeader extends StatelessWidget {
  final bool isGridView;
  final VoidCallback onToggleView;

  const WatchlistHeader({
    super.key,
    required this.isGridView,
    required this.onToggleView,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(s.my_watchlist, style: context.h2),
          IconButton(
            onPressed: onToggleView,
            icon: Icon(
              isGridView ? Icons.view_list : Icons.grid_view,
              color: AppColors.white,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
