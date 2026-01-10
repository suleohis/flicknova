import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flicknova/features/person_detail/domain/entities/filmography_item.dart';
import 'package:flicknova/features/person_detail/presentation/widgets/filmography_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/app_localizations.dart';

class FilmographyList extends StatelessWidget {
  final List<FilmographyItem> filmography;

  const FilmographyList({super.key, required this.filmography});

  @override
  Widget build(BuildContext context) {
    if (filmography.isEmpty) return const SizedBox.shrink();

    final displayItems = filmography.take(10).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            S.of(context).filmography,
            style: context.h4.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: 12.h),
        // Filmography items
        ...displayItems.map((item) => FilmographyItemWidget(item: item)),
        // View complete filmography link
        if (filmography.length > 10)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Center(
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FilmographyListScreen(films: filmography),
                  ),
                ),
                child: Text(
                  S.of(context).view_complete_filmography,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.linkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class FilmographyListScreen extends ConsumerWidget {
  final List<FilmographyItem> films;

  const FilmographyListScreen({super.key, required this.films});

  @override
  build(context, ref) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.filmography),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: films.length,
        itemBuilder: (context, index) {
          final film = films[index];
          return FilmographyItemWidget(item: film);
        },
      ),
    );
  }
}
