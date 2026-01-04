import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingStars extends StatelessWidget {
  final double rating; // Rating out of 10
  final double starSize;

  const RatingStars({super.key, required this.rating, this.starSize = 20});

  @override
  Widget build(BuildContext context) {
    // Convert rating from 0-10 to 0-5 scale
    final double normalizedRating = rating / 2;
    final int fullStars = normalizedRating.floor();
    final int emptyStars = 5 - fullStars;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Filled stars
        ...List.generate(
          fullStars,
          (index) => Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: Icon(
              Icons.star,
              color: AppColors.starFilled,
              size: starSize.sp,
            ),
          ),
        ),
        // Empty stars
        ...List.generate(
          emptyStars,
          (index) => Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: Icon(
              Icons.star,
              color: AppColors.starEmpty,
              size: starSize.sp,
            ),
          ),
        ),
      ],
    );
  }
}
