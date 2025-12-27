import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingBottomPointerWidget extends StatelessWidget {
  final int length;
  final int index;
  const OnboardingBottomPointerWidget({super.key, required this.length, required this.index});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(length, (ind) {
        bool isSelected = index == ind;
        return Container(
        height: 8.h,
        width: isSelected ? 24.w : 8.w,
        margin: EdgeInsets.only(right: ind  != length ? 8:0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : AppColors.white.withValues(alpha: .3),
          borderRadius: BorderRadius.circular(8.r)
        ),
      );
      })
    );
  }
}
