import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  final String userName;

  const ProfileAvatar({super.key, required this.userName});

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(userName);

    return Column(
      children: [
        SizedBox(height: 24.h),
        // Avatar with gradient border
        Container(
          width: 100.r,
          height: 100.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                Color(0xFF00D4FF), // Cyan
                Color(0xFF9D50FF), // Purple
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.background,
            ),
            child: Center(
              child: Text(
                initials,
                style: context.h1.copyWith(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        // User name
        Text(userName, style: context.h3),
        SizedBox(height: 24.h),
      ],
    );
  }
}
