import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/app_localizations.dart';
import '../../domain/entities/movie_entity.dart';
import 'category_chip.dart';
import 'movie_card.dart';

class PopularSection extends StatefulWidget {
  final List<MovieEntity> movies;
  final Function(MovieEntity)? onMovieTap;

  const PopularSection({super.key, required this.movies, this.onMovieTap});

  @override
  State<PopularSection> createState() => _PopularSectionState();
}

class _PopularSectionState extends State<PopularSection> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category chips
        SizedBox(
          height: 40.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              CategoryChip(
                label: s.all,
                isSelected: selectedCategory == 'All',
                onTap: () => setState(() => selectedCategory = 'All'),
              ),
              CategoryChip(
                label: s.tv,
                isSelected: selectedCategory == 'TV',
                onTap: () => setState(() => selectedCategory = 'TV'),
              ),
              CategoryChip(
                label: s.movies,
                isSelected: selectedCategory == 'Movies',
                onTap: () => setState(() => selectedCategory = 'Movies'),
              ),
              CategoryChip(
                label: s.anime,
                isSelected: selectedCategory == 'Anime',
                onTap: () => setState(() => selectedCategory = 'Anime'),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Movie grid
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.6,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 16.h,
            ),
            itemCount: widget.movies.take(6).length,
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              return MovieCard(
                movie: movie,
                width: double.infinity,
                height: 180.h,
                onTap: () => widget.onMovieTap?.call(movie),
              );
            },
          ),
        ),
      ],
    );
  }
}
