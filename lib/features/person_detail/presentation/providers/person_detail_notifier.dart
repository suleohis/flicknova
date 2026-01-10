import 'package:flicknova/core/models/movie_entity.dart';
import 'package:flicknova/core/models/person_detail_entity.dart';
import 'package:flicknova/features/person_detail/domain/entities/filmography_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/tmdb_service.dart';

class PersonDetailState {
  final PersonDetailEntity? person;
  final List<MovieEntity> knownFor;
  final List<FilmographyItem> filmography;
  final bool isLoading;
  final String? error;

  PersonDetailState({
    this.person,
    this.knownFor = const [],
    this.filmography = const [],
    this.isLoading = false,
    this.error,
  });

  PersonDetailState copyWith({
    PersonDetailEntity? person,
    List<MovieEntity>? knownFor,
    List<FilmographyItem>? filmography,
    bool? isLoading,
    String? error,
  }) {
    return PersonDetailState(
      person: person ?? this.person,
      knownFor: knownFor ?? this.knownFor,
      filmography: filmography ?? this.filmography,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class PersonDetailNotifier extends Notifier<PersonDetailState> {
  late final TmdbService _tmdbService;

  @override
  PersonDetailState build() {
    _tmdbService = TmdbService();
    return PersonDetailState();
  }

  Future<void> loadPersonDetail(int personId) async {
    state = state.copyWith(isLoading: true);

    try {
      final personData = await _tmdbService.getPersonDetails(personId);
      final person = PersonDetailEntity.fromJson(personData);

      // Extract known for from both movies and TV shows
      final knownForList = <MovieEntity>[];

      // Add top movies
      if (person.combinedCredits?.movieCast != null) {
        final topMovies = person.combinedCredits!.movieCast
            .take(10)
            .map(
              (movie) => MovieEntity(
                id: movie.id,
                title: movie.title,
                posterPath: movie.posterPath,
                backdropPath: movie.backdropPath,
                overview: movie.overview,
                voteAverage: movie.voteAverage,
                voteCount: movie.voteCount,
                popularity: movie.popularity,
                releaseDate: movie.releaseDate,
                genreIds: movie.genreIds,
                originalLanguage: movie.originalLanguage,
                originalTitle: movie.originalName,
                adult: movie.adult,
                video: false,
                mediaType: 'movie',
              ),
            )
            .toList();
        knownForList.addAll(topMovies);
      }

      // Add top TV shows
      if (person.combinedCredits?.tvCast != null) {
        final topShows = person.combinedCredits!.tvCast
            .take(10)
            .map(
              (show) => MovieEntity(
                id: show.id,
                title: show.name,
                posterPath: show.posterPath,
                backdropPath: show.backdropPath,
                overview: show.overview,
                voteAverage: show.voteAverage,
                voteCount: show.voteCount,
                popularity: show.popularity,
                releaseDate: show.firstAirDate,
                genreIds: show.genreIds,
                originalLanguage: show.originalLanguage,
                originalTitle: show.originalName,
                adult: show.adult,
                video: false,
                mediaType: 'tv',
              ),
            )
            .toList();
        knownForList.addAll(topShows);
      }

      // Sort by popularity and take top 10
      knownForList.sort((a, b) => b.popularity.compareTo(a.popularity));
      final topKnownFor = knownForList.take(10).toList();

      // Build filmography from both movies and TV shows
      final filmographyList = <FilmographyItem>[];

      // Add movies to filmography
      if (person.combinedCredits?.movieCast != null) {
        for (var movie in person.combinedCredits!.movieCast) {
          final year = movie.releaseDate != null
              ? int.tryParse(movie.releaseDate!.split('-').first)
              : null;

          filmographyList.add(
            FilmographyItem(
              id: movie.id,
              title: movie.title,
              character: movie.character,
              year: year,
              mediaType: 'movie',
              posterPath: movie.posterPath,
            ),
          );
        }
      }

      // Add TV shows to filmography
      if (person.combinedCredits?.tvCast != null) {
        for (var show in person.combinedCredits!.tvCast) {
          final year = show.firstAirDate != null
              ? int.tryParse(show.firstAirDate!.split('-').first)
              : null;

          filmographyList.add(
            FilmographyItem(
              id: show.id,
              title: show.name,
              character: show.character,
              year: year,
              mediaType: 'tv',
              posterPath: show.posterPath,
            ),
          );
        }
      }

      // Sort filmography by year (most recent first)
      filmographyList.sort((a, b) {
        if (a.year == null) return 1;
        if (b.year == null) return -1;
        return b.year!.compareTo(a.year!);
      });

      state = state.copyWith(
        person: person,
        knownFor: topKnownFor,
        filmography: filmographyList,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Error loading person detail: $e');
      }
    }
  }
}

final personDetailProvider =
    NotifierProvider<PersonDetailNotifier, PersonDetailState>(
      PersonDetailNotifier.new,
    );
