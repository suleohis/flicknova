import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';

class CustomBottomNavBar extends ConsumerWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    // final authState = ref.watch(authProvider);
    // final avatarUrl = authState.profile?.avatarUrl;

    return Container(
      height: 80.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavBarItem(
            icon: Icons.home_rounded,
            label: s.home,
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavBarItem(
            icon: Icons.search,
            label: s.search,
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _NavBarItem(
            icon: Icons.bookmark_border,
            activeIcon: Icons.bookmark,
            label: s.watchlist,
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          // _NavBarItem(
          //   avatarUrl: avatarUrl,
          //   label: s.profile,
          //   isActive: currentIndex == 3,
          //   onTap: () => onTap(3),
          //   isProfile: true,
          // ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData? icon;
  final IconData? activeIcon;
  final String? avatarUrl;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isProfile;

  const _NavBarItem({
    this.icon,
    this.activeIcon,
    this.avatarUrl,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.isProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.white600;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isProfile)
              _buildProfileIcon()
            else
              Icon(
                isActive && activeIcon != null ? activeIcon : icon,
                color: color,
                size: 24.sp,
              ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileIcon() {
    final color = isActive ? AppColors.primary : AppColors.white600;

    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return Container(
        width: 24.r,
        height: 24.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isActive
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: avatarUrl!,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.white400,
              child: Icon(
                Icons.person,
                color: AppColors.background,
                size: 16.sp,
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.white400,
              child: Icon(
                Icons.person,
                color: AppColors.background,
                size: 16.sp,
              ),
            ),
          ),
        ),
      );
    }

    return Icon(Icons.person, color: color, size: 24.sp);
  }
}
