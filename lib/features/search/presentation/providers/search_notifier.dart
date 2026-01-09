import 'dart:async';

import 'package:flicknova/core/models/genre_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/person_entity.dart';
import '../../../../core/models/tv_show_entity.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/repositories/search_repository.dart';

class SearchState {
  final String query;
  final GenreModel? selectedGenre;
  final List<dynamic>
  results; // Can contain MovieEntity, TVShowEntity, PersonEntity
  final bool isSearching;
  final bool isLoading;
  final bool showResults;
  final String? error;
  final List<GenreModel> genres;
  final List<GenreModel> selectedGenres;

  SearchState({
    this.query = '',
    this.selectedGenre,
    this.results = const [],
    this.isSearching = false,
    this.isLoading = false,
    this.showResults = false,
    this.error,
    this.genres = const [],
    this.selectedGenres = const [],
  });

  SearchState copyWith({
    String? query,
    GenreModel? selectedGenre,
    List<dynamic>? results,
    bool? isSearching,
    bool? isLoading,
    bool? showResults,
    String? error,
    List<GenreModel>? genres,
    List<GenreModel>? selectedGenres,
  }) {
    return SearchState(
      query: query ?? this.query,
      selectedGenre: selectedGenre ?? this.selectedGenre,
      results: results ?? this.results,
      isSearching: isSearching ?? this.isSearching,
      isLoading: isLoading ?? this.isLoading,
      showResults: showResults ?? this.showResults,
      error: error,
      genres: genres ?? this.genres,
      selectedGenres: selectedGenres ?? this.selectedGenres,
    );
  }
}

class SearchNotifier extends Notifier<SearchState> {
  late final SearchRepository _repository;
  Timer? _debounce;

  @override
  SearchState build() {
    _repository = SearchRepositoryImpl();
    Future.delayed(Duration(seconds: 1), () => loadAllData());
    return SearchState();
  }

  Future<void> loadAllData() async {
    await Future.wait([loadFavorites()]);
  }

  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true);
    try {
      final genres = await _repository.getGenres();
      state = state.copyWith(genres: genres ?? [], isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      if (kDebugMode) {
        print('Error loading trending movies: $e');
      }
    }
  }

  void selectedGenreOnTap(GenreModel genre) {
    if  (genre.id == 0) {
      state = state.copyWith(selectedGenres: [], selectedGenre: null);
    }
    else if (state.selectedGenres.contains(genre)) {
      state = state.copyWith(
        selectedGenres: state.selectedGenres.where((g) => g != genre).toList(),
      );
    } else {
      state = state.copyWith(
        selectedGenres: [...state.selectedGenres, genre],
      );
    }
  }

  void updateQuery(String query) {
    state = state.copyWith(query: query);

    // Debounce search
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.isEmpty) {
      state = state.copyWith(showResults: false, results: []);
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      search();
    });
  }

  Future<void> search() async {
    if (state.query.isEmpty) return;

    state = state.copyWith(isSearching: true, showResults: true);

    try {
      // Search across all content types
      final moviesFuture = _repository.searchMovies(query: state.query);
      final tvFuture = _repository.searchTVShows(query: state.query);
      final peopleFuture = _repository.searchPeople(query: state.query);

      final results = await Future.wait([moviesFuture, tvFuture, peopleFuture]);

      final movies = results[0] as List<MovieEntity>;
      final tvShows = results[1] as List<TVShowEntity>;
      final people = results[2] as List<PersonEntity>;

      // Combine all results
      List<dynamic> combinedResults = [];

      // Filter based on selected category
      switch (state.selectedGenre) {
        case 'all':
          // Interleave results for better variety
          combinedResults = _interleaveResults(movies, tvShows, people);
          break;
        case 'action':
        case 'drama':
        case 'sci_fi':
          // Filter by genre (for now, just show movies and TV)
          combinedResults = [...movies, ...tvShows];
          break;
        default:
          combinedResults = [...movies, ...tvShows, ...people];
      }

      state = state.copyWith(results: combinedResults, isSearching: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isSearching: false);
      if (kDebugMode) {
        print('Search error: $e');
      }
    }
  }

  List<dynamic> _interleaveResults(
    List<MovieEntity> movies,
    List<TVShowEntity> tvShows,
    List<PersonEntity> people,
  ) {
    final List<dynamic> result = [];
    final maxLength = [
      movies.length,
      tvShows.length,
      people.length,
    ].reduce((a, b) => a > b ? a : b);

    for (int i = 0; i < maxLength; i++) {
      if (i < movies.length) result.add(movies[i]);
      if (i < tvShows.length) result.add(tvShows[i]);
      if (i < people.length) result.add(people[i]);
    }

    return result;
  }
}

final searchProvider = NotifierProvider<SearchNotifier, SearchState>(
  SearchNotifier.new,
);
