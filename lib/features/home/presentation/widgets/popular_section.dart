import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/person_entity.dart';
import '../../../../core/models/tv_show_entity.dart';
import '../../../see_all/presentation/screens/see_all_screen.dart';
import 'movie_card.dart';
import 'person_card.dart';
import 'section_header.dart';
import 'tv_card.dart';

class PopularSection extends StatelessWidget {
  final List<MovieEntity> popularMovies;
  final List<TVShowEntity> popularTVShows;
  final List<PersonEntity> popularPeople;
  final Function(MovieEntity)? onMovieTap;
  final Function(TVShowEntity)? onTVTap;
  final Function(PersonEntity)? onPersonTap;

  const PopularSection({
    super.key,
    required this.popularMovies,
    required this.popularTVShows,
    required this.popularPeople,
    this.onMovieTap,
    this.onTVTap,
    this.onPersonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Popular Movies
        SectionHeader(
          title: 'Popular Movies',
          onSeeAllTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SeeAllScreen(
                  contentType: 'movie',
                  category: 'popular',
                  title: 'Popular Movies',
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: 230.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: popularMovies.take(10).length,
            itemBuilder: (context, index) {
              final movie = popularMovies[index];
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: MovieCard(
                  movie: movie,
                  width: 120.w,
                  height: 180.h,
                  onTap: () => onMovieTap?.call(movie),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 24.h),

        // Popular TV Shows
        SectionHeader(
          title: 'Popular TV Shows',
          onSeeAllTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SeeAllScreen(
                  contentType: 'tv',
                  category: 'popular',
                  title: 'Popular TV Shows',
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: popularTVShows.take(10).length,
            itemBuilder: (context, index) {
              final tvShow = popularTVShows[index];
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: TVCard(
                  tvShow: tvShow,
                  width: 120.w,
                  height: 180.h,
                  onTap: () => onTVTap?.call(tvShow),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 24.h),

        // Popular People
        SectionHeader(
          title: 'Popular People',
          onSeeAllTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SeeAllScreen(
                  contentType: 'person',
                  category: 'popular',
                  title: 'Popular People',
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: 160.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: popularPeople.take(10).length,
            itemBuilder: (context, index) {
              final person = popularPeople[index];
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: PersonCard(
                  person: person,
                  onTap: () => onPersonTap?.call(person),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
