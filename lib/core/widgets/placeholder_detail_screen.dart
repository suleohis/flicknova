import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceholderDetailScreen extends StatelessWidget {
  final String title;
  final String message;
  final int id;

  const PlaceholderDetailScreen({
    super.key,
    required this.title,
    required this.message,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction_outlined, size: 80.sp, color: Colors.grey),
            SizedBox(height: 24.h),
            Text(message, style: context.h3, textAlign: TextAlign.center),
            SizedBox(height: 12.h),
            Text(
              'ID: $id',
              style: context.bodyMedium.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 32.h),
            Text(
              'This feature is coming soon!',
              style: context.bodySmall.copyWith(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
