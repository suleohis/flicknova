import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGenreRow extends StatelessWidget {
  const ShimmerGenreRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[900]!,
      highlightColor: Colors.grey[800]!,
      period: const Duration(milliseconds: 1500),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        child: Wrap(
          runSpacing: 15.w,
          spacing: 15.h,
          runAlignment: .center,
          crossAxisAlignment: .center,
          alignment: .center,
          children: List.generate(
            12, // Show 8 placeholder pills (covers most genres)
            (_) => const _ShimmerGenreButton(),
          ),
        ),
      ),
    );
  }
}

class _ShimmerGenreButton extends StatelessWidget {
  const _ShimmerGenreButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.black, // Solid base for shimmer
        border: Border.all(color: Colors.grey[800]!, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Container(
        width: 60, // Simulated text width
        height: 18,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
