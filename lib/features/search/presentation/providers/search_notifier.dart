import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/domain/entities/movie_entity.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/repositories/search_repository.dart';

class SearchState {
  final String query;
  final String selectedCategory;
  final List<MovieEntity> results;
  final bool isSearching;
  final bool showResults;
  final String? error;

  SearchState({
    this.query = '',
    this.selectedCategory = 'all',
    this.results = const [],
    this.isSearching = false,
    this.showResults = false,
    this.error,
  });

  SearchState copyWith({
    String? query,
    String? selectedCategory,
    List<MovieEntity>? results,
    bool? isSearching,
    bool? showResults,
    String? error,
  }) {
    return SearchState(
      query: query ?? this.query,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      results: results ?? this.results,
      isSearching: isSearching ?? this.isSearching,
      showResults: showResults ?? this.showResults,
      error: error,
    );
  }
}

class SearchNotifier extends Notifier<SearchState> {
  late final SearchRepository _repository;
  Timer? _debounce;

  @override
  SearchState build() {
    _repository = SearchRepositoryImpl();
    return SearchState();
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

  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
    if (state.query.isNotEmpty) {
      search();
    }
  }

  Future<void> search() async {
    if (state.query.isEmpty) return;

    state = state.copyWith(isSearching: true, showResults: true);

    try {
      final results = await _repository.searchContent(
        query: state.query,
        category: state.selectedCategory,
      );

      state = state.copyWith(results: results, isSearching: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isSearching: false);
      if (kDebugMode) {
        print('Search error: $e');
      }
    }
  }
}

final searchProvider = NotifierProvider<SearchNotifier, SearchState>(
  SearchNotifier.new,
);
