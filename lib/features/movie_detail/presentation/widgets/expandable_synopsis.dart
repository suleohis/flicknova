import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpandableSynopsis extends StatefulWidget {
  final String text;
  final int maxLines;
  final String readMoreText;
  final String showLessText;

  const ExpandableSynopsis({
    super.key,
    required this.text,
    this.maxLines = 3,
    this.readMoreText = 'Read More',
    this.showLessText = 'Show Less',
  });

  @override
  State<ExpandableSynopsis> createState() => _ExpandableSynopsisState();
}

class _ExpandableSynopsisState extends State<ExpandableSynopsis> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: context.bodyMedium.copyWith(
            color: AppColors.white600,
            height: 1.6,
          ),
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (widget.text.length > 120) ...[
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? widget.showLessText : widget.readMoreText,
              style: context.bodyMedium.copyWith(
                color: AppColors.linkColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
