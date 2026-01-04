import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BirthInfoRow extends StatelessWidget {
  final String? birthday;
  final String? placeOfBirth;

  const BirthInfoRow({super.key, this.birthday, this.placeOfBirth});

  String _formatDate(String date) {
    try {
      final parts = date.split('-');
      if (parts.length != 3) return date;

      final year = parts[0];
      final month = parts[1];
      final day = parts[2];

      final months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];

      final monthName = months[int.parse(month) - 1];
      return '$monthName $day, $year';
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (birthday == null && placeOfBirth == null) {
      return const SizedBox.shrink();
    }

    final items = <String>[];
    if (birthday != null) items.add(_formatDate(birthday!));
    if (placeOfBirth != null) items.add(placeOfBirth!);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          Text(
            items[i],
            style: context.bodySmall.copyWith(
              color: AppColors.white600,
              fontSize: 12.sp,
            ),
          ),
          if (i < items.length - 1)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Container(
                width: 3.w,
                height: 3.w,
                decoration: const BoxDecoration(
                  color: AppColors.white600,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ],
    );
  }
}
