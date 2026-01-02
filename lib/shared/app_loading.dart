import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class AppLoading extends StatelessWidget {
  final String? message;
  const AppLoading({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          backgroundColor: AppColors.textSecondary,
        ),
        SizedBox(height: 15),
        if (message != null) ...[
          Text(message!, style: context.body.copyWith(fontSize: 12)),
          SizedBox(height: 15),
        ],
      ],
    );
  }
}
