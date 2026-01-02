import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';

class ActionButtonsRow extends StatelessWidget {
  final VoidCallback? onPlayTap;
  final VoidCallback? onWatchlistTap;
  final VoidCallback? onShareTap;

  const ActionButtonsRow({
    super.key,
    this.onPlayTap,
    this.onWatchlistTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onPlayTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.playButton,
                foregroundColor: AppColors.background,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                elevation: 0,
              ),
              icon: Icon(Icons.play_arrow, size: 24.sp),
              label: Text(
                s.play_trailer,
                style: context.button.copyWith(color: AppColors.background),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          _IconButton(icon: Icons.add, onTap: onWatchlistTap),
          SizedBox(width: 12.w),
          _IconButton(icon: Icons.share, onTap: onShareTap),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _IconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: AppColors.white, size: 24.sp),
        padding: EdgeInsets.all(14.sp),
      ),
    );
  }
}
