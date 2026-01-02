import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class GenreButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final int index;
  final bool isSelected;

  const GenreButton({
    super.key,
    required this.label,
    required this.isSelected,
    this.onPressed,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    const List<Color> baseColors = [
      AppColors.purple, // Purple (Action style)
      AppColors.blue, // Electric Blue
      AppColors.cyan, // Teal/Cyan (Sci-Fi style)
    ];

    const List<Color> glowColors = [
      AppColors.purpleGlow,
      AppColors.blueGlow,
      AppColors.cyanGlow,
    ];

    final baseColor = baseColors[index];
    final glowColor = glowColors[index];

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.shark,
          gradient: !isSelected
              ? null
              : LinearGradient(
                  colors: [
                    baseColor.withValues(alpha: 0.2),
                    baseColor.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          boxShadow: !isSelected
              ? null
              : [
                  BoxShadow(
                    color: glowColor.withValues(alpha: 0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: glowColor.withValues(alpha: 0.2),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
          border: Border.all(
            color: !isSelected ? AppColors.white100 : glowColor,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                color: Colors.black54,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
