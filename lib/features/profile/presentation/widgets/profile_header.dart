import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';

class ProfileHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final VoidCallback? onSettings;

  const ProfileHeader({super.key, this.onBack, this.onSettings});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        onPressed: onBack ?? () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back, color: AppColors.white),
      ),
      title: Text(s.profile, style: context.h3),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: onSettings,
          icon: Icon(Icons.settings_outlined, color: AppColors.white),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
