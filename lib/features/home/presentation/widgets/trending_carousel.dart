import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/movie_entity.dart';
import 'movie_card.dart';

class TrendingCarousel extends StatelessWidget {
  final List<MovieEntity> movies;
  final Function(MovieEntity)? onMovieTap;

  const TrendingCarousel({super.key, required this.movies, this.onMovieTap});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return SizedBox.shrink();
    }

    return SizedBox(
      height: 270.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCard(movie: movie, onTap: () => onMovieTap?.call(movie));
        },
      ),
    );
  }
}
