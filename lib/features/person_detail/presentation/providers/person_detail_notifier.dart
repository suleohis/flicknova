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

      // Extract known for movies from TV credits
      final knownForList = <MovieEntity>[];
      if (person.tvCredits != null) {
        // Get top shows by popularity and convert to MovieEntity format
        final topShows = person.tvCredits!.cast
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

      // Build filmography from TV credits
      final filmographyList = <FilmographyItem>[];
      if (person.tvCredits != null) {
        for (var show in person.tvCredits!.cast) {
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
        knownFor: knownForList,
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
