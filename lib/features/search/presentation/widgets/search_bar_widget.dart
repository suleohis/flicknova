import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onVoiceSearch;

  const SearchBarWidget({super.key, this.onChanged, this.onVoiceSearch});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.searchBarBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: _isFocused ? AppColors.trendingBadge : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.white600, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              style: TextStyle(color: AppColors.white, fontSize: 16.sp),
              decoration: InputDecoration(
                hintText: s.search_movies_shows_actors,
                hintStyle: TextStyle(
                  color: AppColors.white600,
                  fontSize: 16.sp,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onVoiceSearch,
            icon: Icon(Icons.mic, color: AppColors.white600, size: 24.sp),
          ),
        ],
      ),
    );
  }
}
