import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicknova/core/extensions/context_extension.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/models/movie_entity.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flicknova/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/app_localizations.dart';

class KnownForSection extends StatelessWidget {
  final List<MovieEntity> movies;

  const KnownForSection({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).known_for,
                style: context.h4.copyWith(fontWeight: FontWeight.w700),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KnownForListScreen(movies: movies),
                    ),
                  );
                },
                child: Text(
                  S.of(context).see_all,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.linkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: movies.take(10).length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return _KnownForCard(movie: movie);
            },
          ),
        ),
      ],
    );
  }
}

class KnownForListScreen extends ConsumerWidget {
  final List<MovieEntity> movies;

  const KnownForListScreen({super.key, required this.movies});

  @override
  build(context, ref) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.known_for),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AlignedGridView.count(
        padding: EdgeInsets.all(16.w),
        crossAxisCount: 3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 16.h,

        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _KnownForCard(movie: movie);
        },
      ),
    );
  }
}

class _KnownForCard extends StatelessWidget {
  final MovieEntity movie;

  const _KnownForCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate based on media type
        if (movie.mediaType == 'tv') {
          context.push(AppRouter.tvDetail, extra: movie.id);
        } else {
          context.push(AppRouter.movieDetail, extra: movie.id);
        }
      },
      child: Container(
        width: 120.w,
        margin: EdgeInsets.only(right: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: 120.w,
                height: 155.h,
                color: AppColors.cardBackground,
                child: movie.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl: context.tmdbPosterUrl(movie.posterPath),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.cardBackground,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.playButton,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.cardBackground,
                          child: Icon(
                            Icons.movie,
                            color: AppColors.white400,
                            size: 32.sp,
                          ),
                        ),
                      )
                    : Icon(Icons.movie, color: AppColors.white400, size: 32.sp),
              ),
            ),
            SizedBox(height: 8.h),
            // Title
            Text(
              movie.title,
              style: context.bodyMedium.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
