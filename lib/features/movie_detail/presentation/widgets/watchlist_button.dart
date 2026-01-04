import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flicknova/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WatchlistButton extends StatelessWidget {
  final bool isInWatchlist;
  final VoidCallback? onTap;
  final bool isLoading;

  const WatchlistButton({
    super.key,
    required this.isInWatchlist,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return OutlinedButton.icon(
      onPressed: isLoading ? null : onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.watchlistButtonText,
        side: BorderSide(color: AppColors.watchlistButtonBorder, width: 1.5),
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      icon: isLoading
          ? SizedBox(
              width: 20.sp,
              height: 20.sp,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.watchlistButtonText,
              ),
            )
          : Icon(isInWatchlist ? Icons.check : Icons.add, size: 20.sp),
      label: Text(
        s.add_to_watchlist,
        style: context.button.copyWith(
          color: AppColors.watchlistButtonText,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
