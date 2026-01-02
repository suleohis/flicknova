import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';

class SettingsSection extends StatefulWidget {
  final VoidCallback? onLogout;

  const SettingsSection({super.key, this.onLogout});

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.settings, style: context.h3),
          SizedBox(height: 16.h),
          // Notifications toggle
          Row(
            children: [
              Icon(
                Icons.notifications_outlined,
                color: AppColors.primary,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(child: Text(s.notifications, style: context.bodyMedium)),
              Switch(
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
                activeColor: AppColors.primary,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColors.white400.withValues(alpha: 0.1)),
          SizedBox(height: 16.h),
          // Log out button
          GestureDetector(
            onTap: widget.onLogout,
            child: Row(
              children: [
                Icon(Icons.logout, color: Colors.red, size: 24.sp),
                SizedBox(width: 12.w),
                Text(
                  s.log_out,
                  style: context.bodyMedium.copyWith(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
